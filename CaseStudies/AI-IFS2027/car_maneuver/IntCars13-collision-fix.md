# IntCars13: fixing collisions between cars

Date: 2026-10-06

## 1. The request

> I have just uploaded the model IntCars13 to UPPAAL. In general the model allows a number of Cars to drive on a road with several Lanes. In the actual model there are 2 Cars and 1 Lane. Cars will have a current lane and velocity and position. Safety means that two cars should not collide, i.e. must never be at the same lane with the same position. The model allow Cars to change lane and change acceleration providing that no collision will occur in the next time unit. Here the function `brk_dist` is used. From the queries it follows that the two cars can collide. Can you fix the model.

## 2. The original model

- **Global state:** `lane[car_t]`, `acc[car_t]` (in {-2,0,2}), `vel[car_t]`, `pos[car_t] = {0,10}`, `MaxVel = 20`, `Finish = 700`.
- **`Decisions`:** every time unit it sends `go[1]`, then `go[2]` (one after the other, at the same instant). After 1 time unit it calls `updateDiscrete()`, which moves every car at once:
  ```
  pos[i] = pos[i] + vel[i] + acc[i]/2;
  vel[i] = vel[i] + acc[i];
  ```
- **`Car(id)`:** in `Choose` the car picks an acceleration `a` in {-1,0,1} (applied as `acc = 2*a`) and a lane `l`. The original guard:
  ```
  pos[id]<Finish && vel[id]+2*a>=0 && vel[id]+2*a<MaxVel &&
  ((l==lane[id]) or
   ((!exists(i:car_t) overlap_forward(i, l)) &&
    (!exists(i:car_t) overlap_backward(i, l)))) &&
  (a>=0 imply !exists(i:car_t) overlap_forward(i, l))
  ```
  Here `overlap_forward` tests whether the car in front is within this car's braking distance `brk_dist(vel[id],2)`. When `pos[id] >= Finish`, the car goes to `Fin` and sets `vel[id]=0`.
- **`Monitor`:** goes to `ERROR` when the cars have equal positions on the same lane.

Results before the fix:

| Query | Result |
|---|---|
| `Pr[<=100;1000](<> Monitor.ERROR)` | ≈ 0.43 ± 0.03 |
| `E<> Monitor.ERROR` | satisfied |

## 3. Why the cars collide

1. **The car in front may brake in the same step.** The check compares this car's braking distance with where the car in front is *now*. That car can brake hard during the same time unit, so the gap is smaller than assumed.
2. **Moves are decided one after another but applied together.** Car 1 decides, then car 2 decides, then `updateDiscrete()` moves both cars. So a car's decision has to be safe for *any* choice of the other car.
3. **Braking is allowed only once already too close.** Because of `a>=0 imply …`, a car may keep a constant speed until the car in front is already within its braking distance, which is too late.
4. **Finished cars stop instantly.** A car that crosses `Finish` jumps to `vel=0`. That is an infinitely hard stop, and the car behind cannot avoid it.

## 4. The fix

### Key facts

With the discrete update and braking (`acc = -2`), a car with even speed `v` moves `v-1` and slows to `v-2` each step. Until it stops, it covers

  (v-1) + (v-3) + … + 1 = v²/4 = `brk_dist(v,2)`,

so `brk_dist` is *exact* here. Define

  `stop_pos(p,v) = p + brk_dist(v,2)`, the position where the car comes to rest if it brakes now.

For a car behind (f) and the car in front of it (l) on the same lane, the model keeps this rule true at all times:

  **pos[f] < pos[l]  ∧  stop_pos(f) < stop_pos(l)**

- The front car's `stop_pos` never decreases, whatever it chooses (braking keeps it unchanged, and any other choice increases it).
- If both cars brake, the gap changes monotonically. It shrinks while the car behind is faster and grows while it is slower. So the smallest gap is either the current one or the final one, `stop_pos(l) - stop_pos(f) > 0`.
- So **if the rule holds now, the car behind can always keep it true by braking**, whatever the car in front does. The cars can neither collide nor get stuck with no safe move.

Every decision is checked against the *worst case* for the other cars. Therefore the order in which the cars decide does not matter.

### Global declarations (changes)

```c
const int Finish=700;   // use e.g. 100 for exhaustive model checking (A[], E<>)

bool done[car_t];   // car has passed Finish and left the road

// Distance travelled when braking with deceleration a until standstill.
// With the discrete update below (pos += v-1, v -= 2 per step) braking from
// an even velocity v covers exactly v*v/4 = brk_dist(v,2).
int brk_dist(int v,  int a) { return (v*v)/(2*a);}

// Position where car with position p and velocity v comes to rest when braking
int stop_pos(int p, int v) { return p + brk_dist(v,2); }
```

### `Car` local declarations (replacing `overlap_forward` / `overlap_backward`)

```c
// Safety invariant between a follower f and a leader l on the same lane:
//    pos[f] < pos[l]  and  stop_pos(f) < stop_pos(l)
// If it holds, the follower can always keep it by braking, whatever the
// leader does (the leader's stop_pos never decreases).

// Car j is in front of id on the target lane: id's choice a must be safe
// against the worst case for j, i.e. j braking fully in this step.
bool safe_front(car_t j, int a) {
    int np = pos[id] + vel[id] + a;
    int nv = vel[id] + 2*a;
    int jp = pos[j] + (vel[j] >= 2 ? vel[j] - 1 : 0);   // j brakes
    return np < jp && stop_pos(np, nv) < stop_pos(pos[j], vel[j]);
}

// Car j is behind id on a lane id is moving into: the invariant must hold now
// (so j can still brake) and after the step even if j accelerates maximally.
bool safe_back(car_t j, int a) {
    int np = pos[id] + vel[id] + a;
    int nv = vel[id] + 2*a;
    int aj = (vel[j] + 2 < MaxVel) ? 1 : 0;              // j accelerates
    int jp = pos[j] + vel[j] + aj;
    int jv = vel[j] + 2*aj;
    return stop_pos(pos[j], vel[j]) < stop_pos(pos[id], vel[id])
        && jp < np && stop_pos(jp, jv) < stop_pos(np, nv);
}

// Choosing acceleration 2*a and lane l is safe w.r.t. all other cars on l
bool safe(lane_t l, int a) {
    for (j : car_t) {
        if (j != id && !done[j] && lane[j] == l) {
            if (pos[j] > pos[id]) {
                if (!safe_front(j, a)) return false;
            } else if (pos[j] == pos[id]) {
                return false;
            } else if (l != lane[id]) {
                if (!safe_back(j, a)) return false;
            }
        }
    }
    return true;
}
```

### Edges

| Template | Edge | New label |
|---|---|---|
| `Car` | `Choose → (wait)` guard | `pos[id]<Finish && vel[id]+2*a>=0 && vel[id]+2*a<MaxVel && safe(l, a)` |
| `Car` | `Choose → Fin` update | `acc[id]=0, vel[id]=0, done[id]=true` |
| `Monitor` | `→ ERROR` guard | `!done[1] && !done[2] && pos[1]==pos[2] && lane[1]==lane[2]` |

A finished car counts as having left the road. It no longer constrains other cars, and the Monitor ignores it.

### New queries

| Index | Query | Meaning |
|---|---|---|
| 7 | `A[] !Monitor.ERROR` | Safety: cars never collide |
| 8 | `A[] not deadlock` | A safe choice always exists |

## 5. Verification

With `Finish = 700`, the exhaustive check (`E<> Monitor.ERROR` / `A[] !Monitor.ERROR`) did not finish in about 25 minutes: the two cars' positions alone give too many states. UPPAAL then had to be restarted, which reverted the model, so the fix was applied again. For the exhaustive queries, `Finish` was temporarily set to 100.

| Query | Before | After |
|---|---|---|
| `Pr[<=100;1000](<> Monitor.ERROR)` | ≈ 0.43 | 0/1000 runs, so ≤ 0.0037 (95% confidence), with `Finish`=100 **and** `Finish`=700 |
| `E<> Monitor.ERROR` | satisfied | **unsatisfied** (`Finish`=100) |
| `A[] !Monitor.ERROR` | – | **satisfied** (`Finish`=100) |
| `A[] not deadlock` | – | **satisfied** (`Finish`=100) |

`Finish` was then set back to 700. To rerun the exhaustive queries (1, 7, 8), set `Finish` to about 100 first.

## 6. Remarks

- The argument relies on velocities staying even (true here: they start at 0 and change by ±2). With even velocities, `brk_dist(v,2) = v²/4` is exact under the integer update.
- All checks assume the worst case for the other cars, so the fix should work unchanged for more cars and lanes. Only the 2-car / 1-lane instance was verified, though. The `Monitor` is written for cars 1 and 2 and would need generalising.
- Collision is defined as the same lane and the same position at the sampling instants. Because the rule `pos[f] < pos[l]` always holds, cars on the same lane also cannot overtake each other within a step.
