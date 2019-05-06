# Schedulability Analysis of Herschel/Planck Software Using Uppaal

_**Schedulability Analysis of Herschel/Planck Software Using Uppaal**_, Marius Mikučionis, Kim G. Larsen and Brian Nielsen. Quasimodo Industrial Handbook, 2011. [[pre-print](QMchapter.pdf)]

## Abstract
Abstract This chapter shows how UPPAAL is applied in schedulability analysis of
satellite attitude and orbit control software used in Herschel/Planck mission. Our
method transforms the schedulability analysis into reachability analysis performed
by UPPAAL. The chapter briefly describes the schedulability requirements and elaborates
on the modeling framework designed to handle single processor hardware
with a fixed priority preemptive scheduler, detailed task specifications, two resource
sharing protocols and voluntary task suspension. The results include qualitative an-
swers (whether the system is schedulable) as well as quantitative (response and
blocking time estimates) which are comparable with classical response-time analysis.

**Keywords**: schedulability analysis, timed automata, stop-watch automata, modelchecking, verification


### Task Models with Non-Deterministic Times

BCET is 10% less than WCET, **no errors**: [HerschelNonDet-10.xml](HerschelNonDet-10.xml)

BCET is 10% less than WCET, limited to 16 cycles, **no errors**: [HerschelNonDet-10-16.xml](HerschelNonDet-10-16.xml)

BCET is 14% less than WCET, limited to 16 cycles, **no errors**: [HerschelNonDet-14-16.xml](HerschelNonDet-14-16.xml)

BCET is 14% less than WCET, no limits, **possible error**: [HerschelNonDet-14.xml](HerschelNonDet-14.xml)

Trace to **possible error**: [HerschelNonDet-14.xtr.bz2](HerschelNonDet-14.xtr.bz2)

