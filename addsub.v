/*
 this module implements an adder/subtractor for 32 bit unsigned int
 
 . when EN_SUB is 0: performs addition; when EN_SUB is 1: performs subtraction
 
 . overflow is 1 when:
 . . adding two positive number, but got a negative result
 . . adding two negative number, but got a positive result
 . . subtracting a negative number from a positive number, but got a negative result
 . . subtracting a positive number from a negative number, but got a positive result
 
 and reuse some of the partial results to compare the two inputs
 */
module addsub (input [31:0] inA,
               input [31:0] inB,
               input EN_SUB,
               output [31:0] out,
               output overflow,
               output lt,
               output ne);
assign out = 32'h00000000;
assign overflow = 1'b0;
assign lt = 1'b0;
assign ne = 1'b0;
endmodule
