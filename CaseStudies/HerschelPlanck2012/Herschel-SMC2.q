//This file was generated from (Academic) UPPAAL 4.1.12 (rev. 5117), August 2012

/*

*/
E[globalTime <= 156*250000; 1000] (max: WCRT[21])

/*
Response times for primary function task
*/
E[globalTime <= 16*250000; 100] (max: WCRT[21])

/*

*/
simulate 1 [<=156*250000] { runs[21], ready[21], error, primaryF.Error }

/*

*/
simulate 1 [<=1000000] { len }

/*

*/
simulate 10000 [<=85000] { \
  ready[14]+runs[14]+0,\
  ready[15]+runs[15]+3,\
  ready[16]+runs[16]+6,\
  ready[21]+runs[21]-3*primaryF.Error+9,\
  ready[22]+runs[22]+12,\
  ready[30]+runs[30]+15\
}: 1: error

/*

*/
simulate 1 [<=85000] { \
  ready[1]+runs[1]+3,\
  ready[2]+runs[2]+6,\
  ready[3]+runs[3]+9,\
  ready[4]+runs[4]+12,\
  ready[5]+runs[5]+15,\
  ready[6]+runs[6]+18,\
  ready[7]+runs[7]+21,\
  ready[8]+runs[8]+24,\
  ready[9]+runs[9]+27,\
  ready[10]+runs[10]+30,\
  ready[11]+runs[11]+33,\
  ready[12]+runs[12]+36,\
  ready[13]+runs[13]+39,\
  ready[14]+runs[14]+42,\
  ready[15]+runs[15]+45,\
  ready[16]+runs[16]+48,\
  ready[17]+runs[17]+51,\
  ready[18]+runs[18]+54,\
  ready[19]+runs[19]+57,\
  ready[20]+runs[20]+60,\
  ready[21]+runs[21]+63,\
  ready[22]+runs[22]+66,\
  ready[23]+runs[23]+69,\
  ready[24]+runs[24]+72,\
  ready[25]+runs[25]+75,\
  ready[26]+runs[26]+78,\
  ready[27]+runs[27]+81,\
  ready[28]+runs[28]+84,\
  ready[29]+runs[29]+87,\
  ready[30]+runs[30]+90,\
  ready[31]+runs[31]+93,\
  ready[32]+runs[32]+96,\
  ready[33]+runs[33]+99\
}

/*

*/
simulate 1 [<=85000] { \
  ready[1]+runs[1]+2,       ready[2]+runs[2]+4,       ready[3]+runs[3]+6,       ready[4]+runs[4]+8,     ready[5]+runs[5]+10, \
  ready[6]+runs[6]+12,     ready[7]+runs[7]+14,     ready[8]+runs[8]+16,     ready[9]+runs[9]+18,     ready[10]+runs[10]+20,\
  ready[11]+runs[11]+22, ready[12]+runs[12]+24, ready[13]+runs[13]+26, ready[14]+runs[14]+28, ready[15]+runs[15]+30,\
  ready[16]+runs[16]+32, ready[17]+runs[17]+34, ready[18]+runs[18]+36, ready[19]+runs[19]+38, ready[20]+runs[20]+40,\
  ready[21]+runs[21]+42, ready[22]+runs[22]+44, ready[23]+runs[23]+46, ready[24]+runs[24]+48, ready[25]+runs[25]+50,\
  ready[26]+runs[26]+52, ready[27]+runs[27]+54, ready[28]+runs[28]+56, ready[29]+runs[29]+58, ready[30]+runs[30]+60,\
  ready[31]+runs[31]+62, ready[32]+runs[32]+64, ready[33]+runs[33]+66\
}

/*

*/
simulate 1 [<=85000] { \
  ready[1]+runs[1]+66,     ready[2]+runs[2]+64,     ready[3]+runs[3]+62,     ready[4]+runs[4]+60,     ready[5]+runs[5]+58, \
  ready[6]+runs[6]+56,     ready[7]+runs[7]+54,     ready[8]+runs[8]+52,     ready[9]+runs[9]+50,     ready[10]+runs[10]+48,\
  ready[11]+runs[11]+46, ready[12]+runs[12]+44, ready[13]+runs[13]+42, ready[14]+runs[14]+40, ready[15]+runs[15]+38,\
  ready[16]+runs[16]+36, ready[17]+runs[17]+34, ready[18]+runs[18]+32, ready[19]+runs[19]+30, ready[20]+runs[20]+28,\
  ready[21]+runs[21]+26, ready[22]+runs[22]+24, ready[23]+runs[23]+22, ready[24]+runs[24]+20, ready[25]+runs[25]+18,\
  ready[26]+runs[26]+16, ready[27]+runs[27]+14, ready[28]+runs[28]+12, ready[29]+runs[29]+10, ready[30]+runs[30]+8,\
  ready[31]+runs[31]+6,   ready[32]+runs[32]+4,  ready[33]+runs[33]+2\
}

/*

*/
E<> globalTime >= 79600

/*

*/
Pr[<=640*250000](<> error)

/*

*/
Pr[<=16*250000](<> error)

/*

*/
E<> error==1

/*

*/
E<> SwCyc_CycStartIsr.Finishing && runs[4] && job[4]>=19
