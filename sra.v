/*
 this module implements arithmetic right shift operation, which does the following:
 1 shift the bits to the right by (offset) bits, discard the lowest (offset) bits
 2 fill the highest (offset) bits with the sign bit(highest bit) from the original input
 */
module sra (input [31:0] in,
            input [4:0] offset,
            output [31:0] out);
assign out = 32'h00000000;
endmodule
