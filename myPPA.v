/*
 this module implements an adder for 32 bit signed int
 currently, it is a Brent-Kung adder[1], 
 it may become a hybrid between Brent-Kung[1], Sklansky[2] and Kogge-Stone[3] to achieve better tradeoff
 the plan is to design a (2,1,1) prefix network according to the taxomony proposed by Harris[4]
 
 . overflow is 1 when:
 . . adding two positive number, but got a negative result
 . . adding two negative number, but got a positive result
 . . subtracting a negative number from a positive number, but got a negative result
 . . subtracting a positive number from a negative number, but got a positive result
 
 References:
 [1] Brent and Kung, "A Regular Layout for Parallel Adders," in IEEE Transactions on Computers, vol. C-31, no. 3, pp. 260-264, March 1982, doi: 10.1109/TC.1982.1675982.
 [2] J. Sklansky, "Conditional-Sum Addition Logic," in IRE Transactions on Electronic Computers, vol. EC-9, no. 2, pp. 226-231, June 1960, doi: 10.1109/TEC.1960.5219822.
 [3] P. M. Kogge and H. S. Stone, "A Parallel Algorithm for the Efficient Solution of a General Class of Recurrence Equations," in IEEE Transactions on Computers, vol. C-22, no. 8, pp. 786-793, Aug. 1973, doi: 10.1109/TC.1973.5009159.
 [4] D. Harris, "A taxonomy of parallel prefix networks," The Thrity-Seventh Asilomar Conference on Signals, Systems & Computers, 2003, 2003, pp. 2213-2217 Vol.2, doi: 10.1109/ACSSC.2003.1292373.
 */
module myPPA (input [31:0] A,
              input [31:0] B,
              input Cin,
              output [31:0] S,
              output ovf,
              output Cout);

// --- Pre-computation Network ---
// Level 0 Generate and Propagate signal wires
wire [31:0] Gin;
wire [31:0] Pin;


// preparing Genaration and Propagation signals from input operands
genvar i;
generate
for(i = 0; i<32; i = i+1) begin: gen_pg
    and and0(Gin[i],A[i],B[i]);
    xor xor0(Pin[i],A[i],B[i]);
end
endgenerate

// --- Prefix Network ---
wire [31:0] Carry;
/* We will generate the highest carry bit(Cout) in post-computation network
   the prefix network generates carry bits to determine the out put S[31:0]
*/
/*
prefix_network_BK prefix_network(
    .inG(Gin[30:0]),
    .inP(Pin[30:0]),
    .Cin(Cin),
    .Carry(Carry));
*/
prefix_network_KS prefix_network(
    .inG(Gin[30:0]),
    .inP(Pin[30:0]),
    .Cin(Cin),
    .Carry(Carry));

// --- Post-computation Network ---
generate
for(i = 0; i<32; i = i+1) begin: gen_xor_sum
    xor u_xor(
        S[i],
        Carry[i],
        Pin[i]);
end
endgenerate

xor xor_ovf(ovf,Cout,Carry[31]);

wire and_out;

/* generate cout
assign cout=Gin[31]|(Pin[31]&Carry[31]);
*/
and and0(and_out,Pin[31],Carry[31]);
or or0(Cout,Gin[31],and_out);

endmodule
