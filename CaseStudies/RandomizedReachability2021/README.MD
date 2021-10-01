# Randomized Reachability Analysis in UPPAAL: Fast Error Detection in Timed Systems

_**Schedulability of Herschel-Planck Revisited Using Statistical Model Checking**_, Kiviriga A., Larsen K.G., Nyman U. (2021) Randomized Reachability Analysis in Uppaal: Fast Error Detection in Timed Systems. In: Lluch Lafuente A., Mavridou A. (eds) Formal Methods for Industrial Critical Systems. FMICS 2021. Lecture Notes in Computer Science, vol 12863. Springer, Cham. [[DOI]](https://doi.org/10.1007/978-3-030-85248-1_9) [[Springer]](https://link.springer.com/chapter/10.1007/978-3-030-85248-1_9)

## Abstract

*We introduce Randomized Reachability Analysis – an efficient and highly scalable method for detection of “rare event” states, such as errors. Due to the under-approximate nature of the method, it excels at quick falsification of models and can greatly improve the model-based development process: using lightweight randomized methods early in the development for the discovery of bugs, followed by expensive symbolic verification only at the very end. We show the scalability of our method on a number of Timed Automata and Stopwatch Automata models of varying sizes and origin. Among them, we revisit the schedulability problem from the Herschel-Planck industrial case study, where our new method finds the deadline violation three orders of magnitude faster: some cases could previously be analyzed by statistical model checking (SMC) in 23 h and can now be checked in 23 s. Moreover, a deadline violation is discovered in a number of cases that where previously intractable. We have implemented the Randomized Reachability Analysis – and made it available – in the tool Uppaal.*

## Models

The models used in this study are contained in "models/" directory. 
The queries are contained within the model files (.xml).

The folders names prepended with "SMC" contain models with queries of the current UPPAAL mainline syntax. 
The rest of the models were ran with UPPAAL Stratego 4.1.20.