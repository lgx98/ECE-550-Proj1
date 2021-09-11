/*
 this module wraps up an adder to achieve add/sub operations for 32 bit signed int
 
 . when EN_SUB is 0: performs addition; when EN_SUB is 1: performs subtraction
 
 . overflow is 1 when:
 . . adding two positive number, but got a negative result
 . . adding two negative number, but got a positive result
 . . subtracting a negative number from a positive number, but got a negative result
 . . subtracting a positive number from a negative number, but got a positive result
 
 */
module addsub (input [31:0] inA,
               input [31:0] inB,
               input EN_SUB,
               output [31:0] out,
               output overflow);

wire [31:0] negB, B_sel;

// assign negB=~inB;
genvar i;
generate
for(i = 0; i<32; i = i+1) begin: gen_not_B
    not u_not(negB[i],inB[i]);
end
endgenerate

assign B_sel=EN_SUB?negB:inB;

myPPA adder(
    .A(inA),
    .B(B_sel),
    .Cin(EN_SUB),
    .S(out),
    .ovf(overflow),
    .Cout());

endmodule
