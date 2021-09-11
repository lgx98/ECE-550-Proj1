/*
 this module checks if A!=B
 */
module ne (input [31:0] inA,
           input [31:0] inB,
           output out);

wire [63:1] wires;

genvar i;
generate
for(i = 0; i<32; i = i+1) begin: gen_xor
    xor u_xor(wires[i+32],inA[i],inB[i]);
end
endgenerate

/* I am trying to generate a tree structure like this:
 4 5 6 7
 └┬┘ └┬┘
  2   3
  └─┬─┘
    1
 but this code is converted to a 32 input OR gate in netlist viewer
*/

generate
for(i = 1; i<32; i = i+1) begin: gen_tree
    or u_or(wires[i],wires[2*i],wires[2*i+1]);
end
endgenerate

assign out=wires[1];

endmodule
