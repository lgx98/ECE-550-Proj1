# ALU - ADD/SUB/CMP

## π¨βπ» Group Members

|Name|NetID|
|---|---|
|Guangxuan Li|gl137|
|Zhigang Wei|zw261|

## π Description

Module tree:

```
alu
ββββaddsub
β   ββββmyPPA
β       ββββprefix_network_SK   -- Sklansky: even faster
β       β   ββββop_o
β       ββββ//prefix_network_KS -- Kogge-Stone: better delay
β       β   ββββop_o
β       ββββ//prefix_network_BK -- Brent-Kung: high delay, deprecated
β           ββββop_o
ββββlt
ββββne
ββββbitwise_and
ββββbitwise_or
ββββsll
ββββsra
```

- [x] alu.v: top level entity, selects out from submodules according to opcode.
- [x] prefix_network_*.v: we implemented and tested [Brent-Kung](https://doi.org/10.1109/TC.1982.1675982), [Kogge-Stone](https://doi.org/10.1109/TC.1973.5009159) and [Sklansky](https://doi.org/10.1109/TEC.1960.5219822) prefix carry generation networks. After gate level simulation and fitting, we decided to use Sklansky adder for its low latency and low LUT usage. You can comment and uncomment the code in myPPA.v to change between those implementations.

- [x] myPPA.v: a adder with two integer inputs, a sum output, a Carry-in, a Carry-out(treating inputs as unsigned), and a overflow(treating inputs as signed) output.

- [x] addsub.v: added some logics around the adder to invert the input B to achieve subtraction operation.

- [x] lt.v: uses the sign bit from subtraction result and overflow flag to decide if A is less than B.

- [x] ne.v: compares A and B bit-by-bit to determine if they are not equal.

- [ ] bitwise_and.v: not implemented yet, dummy code.

- [ ] bitwise_or.v: not implemented yet, dummy code.

- [x] sll.v: logical shift left.

- [x] sra.v: arithetic shift right.

## π Bugs and Issues

Nothing at the moment.

