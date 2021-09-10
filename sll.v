/*
 this module implements logical left shift operation, which does the following:
 1 shift the bits to the left by (offset) bits, discard the highest (offset) bits
 2 fill the lowest (offset) bits with 0
 */
module sll (input [31:0] in,
            input [4:0] offset,
            output [31:0] out);
assign out = 32'h00000000;
endmodule
