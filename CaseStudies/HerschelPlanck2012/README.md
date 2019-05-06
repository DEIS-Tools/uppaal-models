# Schedulability of Herschel-Planck Revisited Using Statistical Model Checking

_**Schedulability of Herschel-Planck Revisited Using Statistical Model Checking**_, Alexandre David, Kim G. Larsen, Axel Legay and Marius Mikučionis. *Leveraging Applications of Formal Methods, Verification and Validation. Applications and Case Studies (ISoLA 2012)*, October 2012, Springer-Verlag Berlin Heidelberg. ISBN 978-3-642-34032-1, 978-3-642-34031-4. [[DOI](https://doi.org/10.1007/978-3-642-34032-1_28)]
[[bib](ISoLA2012.bib)] [[pre-print](ISoLA2012.pdf)] [[slides](ISoLA2012-talk.pdf)] [[ICTSS 2012 tutorial slides](ICTSS2012-tutorial.pdf)]

## Abstract

Schedulability analysis is a main concern for several embedded applications due to their safety-critical nature. The classical method of response time analysis provides an efficient technique used in industrial practice. However, the method is based on conservative assumptions related to execution and blocking times of tasks. Consequently, the method may falsely declare deadline violations that will never occur during execution. This paper is a continuation of previous work of the authors in applying extended timed automata model checking (using the tool UPPAAL) to obtain more exact schedulability analysis, here in the presence of non-deterministic computation times of tasks given by intervals [BCET,WCET]. Considering computation intervals makes the schedulability of the resulting task model undecidable. Our contribution is to propose a combination of model checking techniques to obtain some guarantee on the (un)schedulability of the model even in the presence of undecidability.

## Model Files

Uppaal SMC task model of Herschel setup: [Herschel-SMC2.xml](Herschel-SMC2.xml)

Queries for the task model: [Herschel-SMC2.q](Herschel-SMC2.q)

Simplified task model used in paper: [schedulability4.xml](schedulability4.xml)

Queries for the simplified task model: [schedulability4.q](schedulability4.q)

The material is taken from [AAU](http://people.cs.aau.dk/~marius/Terma/).
