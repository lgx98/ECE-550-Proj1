/*
 this module implements arithmetic right shift operation, which does the following:
 1 shift the bits to the right by (offset) bits, discard the lowest (offset) bits
 2 fill the highest (offset) bits with the sign bit(highest bit) from the original input
 */
module sra (input [31:0] in,
            input [4:0] offset,
            output [31:0] out);

wire sign=in[31];

wire [31:0] temp[5:0];
assign temp[0] = in;

genvar i;
generate
for (i = 0 ;i < 5 ;i = i + 1) begin: gen_shift
    assign temp[i+1] =
    offset[i]?
        {{(1<<i){sign}},temp[i][31:(1<<i)]}
    :
        temp[i];
end
endgenerate

assign out=temp[5];

endmodule
