/*
 this module implements logical left shift operation, which does the following:
 1 shift the bits to the left by (offset) bits, discard the highest (offset) bits
 2 fill the lowest (offset) bits with 0
 */
module sll (input [31:0] in,
            input [4:0] offset,
            output [31:0] out);

wire [31:0] temp[5:0];
assign temp[0] = in;

genvar i;
generate
for (i = 0 ;i < 5 ;i = i + 1) begin: gen_shift
    assign temp[i+1] =
    offset[i]?
        {temp[i][(31-(1<<i)):0],{(1<<i){1'b0}}}
    :
        temp[i];
end
endgenerate

assign out=temp[5];

endmodule
