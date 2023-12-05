//This file was generated from (Academic) UPPAAL 4.1.20-stratego-11 (rev. 323D987339A98B21), December 2022

/*
Eventually all projects can be completed within 14 time units
*/
E<> forall (pid : Pid) Project(pid).isDone() && global_time <= 14
