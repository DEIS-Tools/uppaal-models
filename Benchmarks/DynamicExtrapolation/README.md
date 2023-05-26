# Dynamic Extrapolation in Extended Timed Automata

_**Dynamic Extrapolation in Extended Timed Automata**_,
Nicolaj Ø. Jensen, Peter G. Jensen, Kim G. Larsen (2023). In: TBD

## Abstract

Abstractions, such as extrapolation, ensure termination of timed automata model checking.
However, such methods are normally only defined for classical timed automata, whereas modern tools like Uppaal take as input timed automata extended with discrete data and C-like language constructs (XTA) making classical extrapolation excessively overapproximating if even applicable.
In this paper, we propose a new dynamic extrapolation techinque for XTAs which utilizes information from the immediate state of the search to find more precise extrapolation values.
We determine which code snippets are relevant to obtain the extrapolation values ahead of verification using static analysis and then execute these dynamically during verification.
We implement our novel extrapolation technique in Uppaal and find that it reduces the zone graph sizes by 34.7% overall compared to a classic location-clock-based extrapolation.
The best case is an 82.7% reduction and the worst case is a surprising 8.2% increase.

## Models

The models used in this study can be found in the subdirectories of this directory.
The models have dynamic time constraints, i.e. constraints where clocks are compared to variable expressions.
Some of them have come in two variants, with and without user-defined integer ranges for variables.
The models are fairly simple but can be scaled.
In the study, we have primarily been measuring the state space size using the `false.q` queries (`E<> false`), but other queries are available in the subdirectories.

### Simple (simple-*I*)
The articial example from [S. Lund et al. 2021](https://link.springer.com/chapter/10.1007/978-3-030-85037-1_6), designed to showcase the issues of relying purely on type information for extrapolation in XTA.


### TCP Backoff Protocol (TCP-*V*-*N*)
In this model, *N* clients estimates a congestion window based on how often their messages to the server is lost/denied.
They limit their rate of messaging inverse proportionally to the size of the congestion window.
Our experiments include both an additive-increase/muliplicative-decrease (AIMD) backoff protocol and a linear backoff protocol.

### Gossip Protocol (gossip-*V*-*N*)
In this classical model of information sharing, *N* components each has a secret.
They can call each other and exchange their secrets.
We use two variants of this model.
In one variant, the duration of the call between two components is the union of their known secrets.
In the other, the duration is the size of the symmetric difference of their known secrets plus one.

### Firefly Synchronization (firefly-*W*-*H*-*N*)
In this model, *N* fireflies lives on an *W* by *H* grid.
A firefly blinks every *60 − t* seconds, where *t* is the number of times it has seen another firefly in the same cell blink at least 30 seconds after its own latest blink.
Over time this results in the firelies blinking in synchronization.
See https://ncase.me/fireflies/.

### Leader Election (leader-*N*)
In this model, N network nodes attempts to elect a leader by communicating witch each other.
The timeout deadline is dynamically calculated based on the number of hops a message do.

### Printing Projects (printing-projects-*M*-*P*)
In this model, *P* projects requires a varying number of pieces printed.
Each piece has a different size and will therefore take different amount of time to print.
There are *M* printers available.
