# Schedulability Analysis Using Uppaal: Herschel-Planck Case Study

_**Schedulability Analysis Using Uppaal: Herschel-Planck case study**_, Marius Mikučionis, Kim Guldstrand Larsen, Jacob Illum Rasmussen, Brian Nielsen, Arne Skou, Palm Steen Ulrik, Jan Storbank Pedersen, Poul Hougaard. _Proceedings of the 4th international conference on Leveraging applications of formal methods, verification, and validation - Volume Part II (ISOLA 2010)_, October 2010, Springer-Verlag, ISBN 3-642-16560-5, 978-3-642-16560-3. [[DOI](https://doi.org/10.1007/978-3-642-16561-0_21)] [[bib](ISoLA2010.bib)] [[pre-print](ISoLA2010.pdf)] [[slides](ISoLA2010-talk.pdf)]

## Abstract

We propose a modeling framework for performing schedulability analysis by using UPPAAL real-time model-checker. The framework is inspired by a case study where schedulability analysis of a satellite system is performed. The framework assumes a single CPU hardware where a fixed priority preemptive scheduler is used in a combination with two resource sharing protocols and in addition voluntary task suspension is considered. The contributions include the modeling framework, its application on an industrial case study and a comparison of results with classical response time analysis.

## Model files

Task model with deteriministic times: [HerschelEvents2.xml](HerschelEvents2.xml)

Task model with sporadic times (*results in state space explosion*): [HerschelEvents2spor.xml](HerschelEvents2spor.xml)

Queries: [HerschelEvents2.q](HerschelEvents2.q)

## Results

Summary: [results.ods](results.ods) [results.xlsx](results.xlsx)

Worst Case Response Time estimates for various cycle limits: [herschel.txt](herschel.txt)

Worst Case Response Time estimates for various cycle limits: [herschel2.txt](herschel2.txt)

### Gantt chart of 1 cycle (high resolution) [pdf](gantt-1c-12943x792.pdf) [png](gantt-1c-12943x792.png)
![Gantt chart of 1 cycle](gantt-1c-12943x792.png)

### Gantt chart of 2 cycles [pdf](gantt-2c-5307x792.pdf) [png](gantt-2c-5307x792.png)
![Gantt chart of 2 cycles](gantt-2c-5307x792.png)


Material is taken from [AAU](http://people.cs.aau.dk/~marius/Terma/).
