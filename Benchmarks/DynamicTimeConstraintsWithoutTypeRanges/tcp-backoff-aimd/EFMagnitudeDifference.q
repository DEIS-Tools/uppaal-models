//This file was generated from (Academic) UPPAAL 4.1.20-stratego-11 (rev. 323D987339A98B21), December 2022

/*
The size of the congestion window of client 0 may become 10 times greater than the size of the congestion window of client 1
*/
E<> Client(0).cw > 10 * Client(1).cw
