//This file was generated from (Academic) UPPAAL 4.1.20-stratego-11 (rev. 323D987339A98B21), December 2022

/*
Node 0 can learn all secrets without node 1 learning any (false)
*/
E<> Node(0).secrets == ALL_SECRETS && Node(1).numSecrets() == 1 && forall (i : id_t) Node(i).Waiting
