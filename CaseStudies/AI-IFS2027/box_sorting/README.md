# Box Sorting Conveyor Belt

* [Claude Session Report](claude_report.pdf)
* [boxesARTES06.xml](boxesARTES06.xml) original model contains buffer-overflow vulnerability triggered by too many boxes on belt. The fix has not been published before.
* [FixedBoxesBig.xml](FixedBoxesBig.xml) fixed buffer-overflow by Claude (contains state space explosion due to 8 boxes).
* [BigBoxesSymmetric.xml](BigBoxesSymmetric.xml) state space reduced by symmetry reduction applied by Claude.

| Part     | Original model | Fixed buffer overflow | Symmetry reduction |
|----------|----------------|-----------------------|--------------------|
| TaskMAIN | ![TaskMAIN](orig/TaskMAIN.svg) | ![TaskMAIN](fixed/TaskMAIN.svg) | ![TaskMAIN](scalar/TaskMAIN.svg) |
| TaskPUSH | ![TaskPUSH](orig/TaskPUSH.svg) | ![TaskPUSH](fixed/TaskPUSH.svg) | ![TaskPUSH](scalar/TaskPUSH.svg) |
| Piston | ![Piston](orig/Piston.svg) | ![Piston](fixed/Piston.svg) | ![Piston](scalar/Piston.svg) |
| Dumb | ![Dumb](orig/Dumb.svg) | ![Dumb](fixed/Dumb.svg) | ![Dumb](scalar/Dumb.svg) |
| Guard | ![Guard](orig/Guard.svg) | ![Guard](fixed/Guard.svg) | ![Guard](scalar/Guard.svg) |
| RedBox | ![RedBox](orig/RedBox.svg) | ![RedBox](fixed/RedBox.svg) | ![RedBox](scalar/RedBox.svg) |
| BlackBox | ![BlackBox](orig/BlackBox.svg) | ![BlackBox](fixed/BlackBox.svg) | ![BlackBox](scalar/BlackBox.svg) |

## Original Global Declarations
```cpp
const int ctime = 75;

int[0,1] active;
clock x, time;

chan   eject, ok;
urgent chan blck, red, remove, go;
```

## Original Queries
```cpp
E<> R2.end
E<> R1.end
E<> R1.off
E<> R2.off
E<> B2.off
E<> B1.off
E<> B2.end
E<> B1.end
```

### Fixed Global Declarations

```cpp
const int ctime = 75;

// Fix: one eject timer per black box that can be in transit between the
// sensor and the piston (previously a single timer x was reset by every
// detection, overwriting the pending eject of an earlier black box).
// Boxes are placed >= 10 apart and travel 75 from sensor to piston, so at
// most 8 black boxes can be in transit at once: 8 timers always suffice.
const int NT = 8;               // number of eject timers
typedef int[0,NT-1] tid_t;

bool  active[NT];               // timer i is counting down to an eject
clock x[NT];                    // timer i: time since its black box was sensed
clock time;

chan   eject, ok;
urgent chan blck, red, remove, go;

// index of a free timer, or NT if all are busy
int[0,NT] firstFree() {
    for (i : tid_t)
        if (!active[i]) return i;
    return NT;
}

// start the first free timer for a newly sensed black box
void startTimer() {
    int i = firstFree();
    x[i] = 0;
    active[i] = true;
}
```

## Fixed Model Queries

```cpp
// No black box ever reaches the end of the belt.
A[] not (B1.end || B2.end || B3.end || B4.end || B5.end)

// No red box is ever removed from the belt.
A[] not (R1.off || R2.off || R3.off)

// Whenever the system has come to rest, every black box is off and every red box is at the end.
A[] deadlock imply (B1.off && B2.off && B3.off && B4.off && B5.off && R1.end && R2.end && R3.end)

// The intended final outcome is reachable.
E<> B1.off && B2.off && B3.off && B4.off && B5.off && R1.end && R2.end && R3.end

// Stress check: all five black boxes can be between sensor and piston at the same time.
E<> B1.on2 && B2.on2 && B3.on2 && B4.on2 && B5.on2

// Sanity: every pending eject timer stays within its deadline.
A[] TaskMAIN.S0 imply (forall (i : tid_t) (active[i] imply x…
```

## Symmetry Reduction: Global Declarations

```cpp
const int ctime = 75;

// Fix: one eject timer per black box that can be in transit between the
// sensor and the piston (previously a single timer x was reset by every
// detection, overwriting the pending eject of an earlier black box).
// Boxes are placed >= 10 apart and travel 75 from sensor to piston, so at
// most 8 black boxes can be in transit at once: 8 timers always suffice.
const int NT = 8;               // number of eject timers
const int NB = 5;               // number of black boxes
const int NR = 3;               // number of red boxes

// Scalar sets: identical boxes/timers are interchangeable, which lets
// UPPAAL apply symmetry reduction.
typedef scalar[NT] tid_t;
typedef scalar[NB] bid_t;
typedef scalar[NR] rid_t;

bool  active[tid_t];            // timer i is counting down to an eject
clock x[tid_t];                 // timer i: time since its black box was sensed

chan   eject, ok;
urgent chan blck, red, remove, go;
```

## Symmetry Reduction: Queries
```cpp
// No black box ever reaches the end of the belt.
A[] forall (i : bid_t) not BlackBox(i).end

// No red box is ever removed from the belt.
A[] forall (j : rid_t) not RedBox(j).off

// Whenever the system has come to rest, every black box is off and every red box is at the end.
A[] deadlock imply ((forall (i : bid_t) BlackBox(i).off) && (forall (j : rid_t) RedBox(j).end))

// The intended final outcome is reachable.
E<> (forall (i : bid_t) BlackBox(i).off) && (forall (j : rid_t) RedBox(j).end)

// Stress check: all black boxes can be between sensor and piston at the same time.
E<> forall (i : bid_t) BlackBox(i).on2

// Sanity: every pending eject timer stays within its deadline.
A[] forall (i : tid_t) (active[i] imply x[i] <= ctime)
```
