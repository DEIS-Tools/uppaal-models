# Fischer's Mutual Exclusion Protocol

* [Newcomer's Report](newcomer_report.pdf)
* [Claude Session Report](claude_report.pdf)
* [fischer.xml](fischer.xml) model, the same as in UPPAAL Examples menu.

## Global Declarations
```cpp
typedef int[1,6] id_t;
int id;
```

## Template P
![P](P.svg)

Local declarations:
```cpp
clock x;
const int k = 2;
```

## System Declarations
```cpp
system P;
```
