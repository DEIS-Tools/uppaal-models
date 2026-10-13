# Analysis and Verification of Quantum Communication Protocols in UPPAAL
This folder contains artifacts for "Analysis and Verification of Quantum Communication Protocols in UPPAAL" paper for CAV'26.

Download the entire artifact with instructions in `README.md`: [artifact.zip](artifact.zip)

## Model Previews

### bsdc-enumerated.xml

2-bit quantum process `Quantum2`:

![Quantum](Quantum2.svg)

Sender process `SenderTimeslotted`:

![Sender](SenderTimeslotted.svg)

Receiver `ReceiverTimeslotted`:

![Receiver](ReceiverTimeslotted.svg)

`Monitor` with two buffers:

![Monitor](Monitor.svg)

Monitor with sliding-window buffer (`MonitorOld`):

![MonitorOld](MonitorOld.svg)

### bsdc-density-matrix.xml

Quantum process with density matrix operations `Qstate2` for 2 qubits:

![Qstate2](Qstate2.svg)

Quantum process with density matrix operations `Qstate4` for 4 qubits:

![Qstate4](Qstate4.svg)

`Distiller`:

![Distiller](Distiller.svg)

Sender with distillation `SenderShifting`:

![SenderShifting](SenderShifting.svg)

