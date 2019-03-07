//This file was generated from (Academic) UPPAAL 4.1.10 (rev. 5042), April 2012

/*
Simple run visualization as a Gantt chart where:
base level corresponds to Idle state, 
base+1 corresponds to a ready state, 
base+2 corresponds to ready and running, and
below base means error has been reached.
*/
simulate 1 [<=300] { \
  (T(1).Ready+T(1).Computing+T(1).Release+runs[1]-3*T(1).Error)+6, \
  (T(2).Ready+T(2).Computing+T(2).Release+runs[2]-3*T(2).Error)+3,\
  (T(3).Ready+T(3).Computing+T(3).Release+runs[3]-3*T(3).Error)+0\
}

/*
Validate in a Gantt chart like plot, where task location is encoded as level, and error shows up as abrupt dive down.
*/
simulate 1 [<=300] { \
(0.25*T(1).Ready+0.5*T(1).Computing+0.75*T(1).Release+0.1*runs[1]-T(1).Error)+0, \
(0.25*T(2).Ready+0.5*T(2).Computing+0.75*T(2).Release+0.1*runs[2]-T(2).Error)+1, \
(0.25*T(3).Ready+0.5*T(3).Computing+0.75*T(3).Release+0.1*runs[3]-T(3).Error)+2\
}

/*
Check symbolically for schedulability
*/
E<> error

/*
Try to get probabilistic counter-example disproving schedulability
*/
Pr[<=200](<> error)

/*
Perform a large number of simulations and display one run where error is reachable (if such run is found).
*/
simulate 50000 [<=300] { \
  (T(1).Ready+T(1).Computing+T(1).Release+runs[1]-3*T(1).Error)+6, \
  (T(2).Ready+T(2).Computing+T(2).Release+runs[2]-3*T(2).Error)+3,\
  (T(3).Ready+T(3).Computing+T(3).Release+runs[3]-3*T(3).Error)+0\
}: 1 : error

/*

*/
simulate   100 [<=200] { \
(0.25*T(1).Ready+0.5*T(1).Computing+0.75*T(1).Release+0.1*runs[1]-2*T(1).Error)+2, \
(0.25*T(2).Ready+0.5*T(2).Computing+0.75*T(2).Release+0.1*runs[2]-2*T(2).Error)+1, \
(0.25*T(3).Ready+0.5*T(3).Computing+0.75*T(3).Release+0.1*runs[3]-2*T(3).Error)+0\
}: error

/*
Make a Gantt chart-like plot of the error trace. The task location is encoded in the level, while error shows up as abrupt dive below the base level.
*/
simulate 50000 [<=200] { \
  (0.25*T(1).Ready+0.5*T(1).Computing+0.75*T(1).Release+0.1*runs[1]-2*T(1).Error)+2, \
  (0.25*T(2).Ready+0.5*T(2).Computing+0.75*T(2).Release+0.1*runs[2]-2*T(2).Error)+1, \
  (0.25*T(3).Ready+0.5*T(3).Computing+0.75*T(3).Release+0.1*runs[3]-2*T(3).Error)+0,\
}: error

/*
Estimate a distribution of response times for Task 1
*/
E[<=200; 50000] (max: T(1).r)

/*
Estimate a distribution of response times for Task 2
*/
E[<=200; 50000] (max: T(2).r)

/*
Estimate a distribution of response times for Task 3
*/
E[<=200; 50000] (max: T(3).r)

/*

*/
sup: usage

/*
Estimate worst response times using symbolic reachability method.
Note that the system should be schedulable in the first place (otherwise response times will be infinit).
[System is schedulable when f>=84, or Deadline[1]=55 for any f]
*/
sup: T(1).r, T(2).r, T(3).r
