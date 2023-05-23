//This file was generated from (Academic) UPPAAL 4.1.20-stratego-11 (rev. 323D987339A98B21), December 2022

/*
The fireflies are guaranteed to eventually synchronize their blinking (only satisfied if W=1 and H=1)
*/
A<> forall (i : int[0,N-1]) Firefly(i).t == PERIOD
