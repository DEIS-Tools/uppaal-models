//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4494), May 2010

/*
Find a deadlock (check whether the system is schedulable)
*/
E<> error

/*
Quickly go to the end of 2nd cycle.
*/
E<> globalTime==2*150*1000

/*
Go to the end of TIMELIMIT and inspect the average CPU usage
*/
E<> cycle==CYCLELIMIT

/*
Total CPU top idle and usage time and compare it with globalTime
*/
sup:idleTime, usedTime, globalTime

/*
Goto to time point 138713 (e.g. deadlock is at that point)
*/
E<> FdirEvents.Postpone && cycle==2

/*
find Worst Case Responce Times
*/
sup: WCRT[0], WCRT[1], WCRT[2], WCRT[3], WCRT[4], WCRT[5], WCRT[6], WCRT[7], WCRT[8], WCRT[9],\
WCRT[10], WCRT[11], WCRT[12], WCRT[13], WCRT[14], WCRT[15], WCRT[16], WCRT[17], WCRT[18], WCRT[19],\
WCRT[20], WCRT[21], WCRT[22], WCRT[23], WCRT[24], WCRT[25], WCRT[26], WCRT[27], WCRT[28], WCRT[29],\
WCRT[30], WCRT[31], WCRT[32], WCRT[33], idleTime, usedTime, globalTime

/*
is it possible that primary functions are preempted in between operations? [No]
*/
E<> primaryF.Next && !runs[21]

/*
when does Task 31 reach it's sup(WCRT)? asnwer: 7th cycle at 1'611'553
*/
E<> WCRT[31] >= 35413

/*
when does Task 32 reach it's sup(WCRT)? answer: 9th cycle
*/
E<> WCRT[32] >= 70603

/*
when does PrimaryF get blocked?
*/
E<> blocked[21]==1

/*
when does StsMon_P gets blocked?
*/
E<> blocked[25]==1

/*
Is it possible for a task to be blocked?
*/
E<> exists(i:taskid_t) blocked[i]==1
