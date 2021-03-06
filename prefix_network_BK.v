/*
 this module implements the carry generation network of a Brent-Kung adder[1].
 
 Reference:
 [1] Brent and Kung, "A Regular Layout for Parallel Adders," in IEEE Transactions on Computers, vol. C-31, no. 3, pp. 260-264, March 1982, doi: 10.1109/TC.1982.1675982.
 */
module prefix_network_BK (
    input [30:0] inG,
    input [30:0] inP,
    input Cin,
    output [31:0] Carry);

// Level 0
// Generate and Propagate signal wires
wire [31:0] l0_G;
wire [31:0] l0_P;

// by definition, the input Generate signal is Carry-In, and the input Propagate signal is 0.
assign l0_G = {inG, Cin};
assign l0_P = {inP, 1'b0};

genvar i;
// Level 1
// Generate and Propagate signal wires
wire [31:0] l1_G;
wire [31:0] l1_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l1
    if (i%2==1) begin
        op_o u_op_o(
            .Gh(l0_G[i]),
            .Ph(l0_P[i]),
            .Gl(l0_G[i-1]),
            .Pl(l0_P[i-1]),
            .Go(l1_G[i]),
            .Po(l1_P[i]));
    end else begin
        assign l1_G[i]=l0_G[i];
        assign l1_P[i]=l0_P[i];
    end
end
endgenerate


// Level 2
// Generate and Propagate signal wires
wire [31:0] l2_G;
wire [31:0] l2_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l2
    if (i%4==3) begin
        op_o u_op_o(
            .Gh(l1_G[i]),
            .Ph(l1_P[i]),
            .Gl(l1_G[i-2]),
            .Pl(l1_P[i-2]),
            .Go(l2_G[i]),
            .Po(l2_P[i]));
    end else begin
        assign l2_G[i]=l1_G[i];
        assign l2_P[i]=l1_P[i];
    end
end
endgenerate


// Level 3
// Generate and Propagate signal wires
wire [31:0] l3_G;
wire [31:0] l3_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l3
    if (i%8==7) begin
        op_o u_op_o(
            .Gh(l2_G[i]),
            .Ph(l2_P[i]),
            .Gl(l2_G[i-4]),
            .Pl(l2_P[i-4]),
            .Go(l3_G[i]),
            .Po(l3_P[i]));
    end else begin
        assign l3_G[i]=l2_G[i];
        assign l3_P[i]=l2_P[i];
    end
end
endgenerate

// Level 4
// Generate and Propagate signal wires
wire [31:0] l4_G;
wire [31:0] l4_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l4
    if (i%16==15) begin
        op_o u_op_o(
            .Gh(l3_G[i]),
            .Ph(l3_P[i]),
            .Gl(l3_G[i-8]),
            .Pl(l3_P[i-8]),
            .Go(l4_G[i]),
            .Po(l4_P[i]));
    end else begin
        assign l4_G[i]=l3_G[i];
        assign l4_P[i]=l3_P[i];
    end
end
endgenerate

// Level 5
// Generate and Propagate signal wires
wire [31:0] l5_G;
wire [31:0] l5_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l5
    if (i%32==31) begin
        op_o u_op_o(
            .Gh(l4_G[i]),
            .Ph(l4_P[i]),
            .Gl(l4_G[i-16]),
            .Pl(l4_P[i-16]),
            .Go(l5_G[i]),
            .Po(l5_P[i]));
    end else begin
        assign l5_G[i]=l4_G[i];
        assign l5_P[i]=l4_P[i];
    end
end
endgenerate


// Level 6
// Generate and Propagate signal wires
wire [31:0] l6_G;
wire [31:0] l6_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l6
    if ((i%16==7)&&(i>=16)) begin
        op_o u_op_o(
            .Gh(l5_G[i]),
            .Ph(l5_P[i]),
            .Gl(l5_G[i-8]),
            .Pl(l5_P[i-8]),
            .Go(l6_G[i]),
            .Po(l6_P[i]));
    end else begin
        assign l6_G[i]=l5_G[i];
        assign l6_P[i]=l5_P[i];
    end
end
endgenerate

// Level 7
// Generate and Propagate signal wires
wire [31:0] l7_G;
wire [31:0] l7_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l7
    if ((i%8==3)&&(i>=8)) begin
        op_o u_op_o(
            .Gh(l6_G[i]),
            .Ph(l6_P[i]),
            .Gl(l6_G[i-4]),
            .Pl(l6_P[i-4]),
            .Go(l7_G[i]),
            .Po(l7_P[i]));
    end else begin
        assign l7_G[i]=l6_G[i];
        assign l7_P[i]=l6_P[i];
    end
end
endgenerate

// Level 8
// Generate and Propagate signal wires
wire [31:0] l8_G;
wire [31:0] l8_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l8
    if ((i%4==1)&&(i>=4)) begin
        op_o u_op_o(
            .Gh(l7_G[i]),
            .Ph(l7_P[i]),
            .Gl(l7_G[i-2]),
            .Pl(l7_P[i-2]),
            .Go(l8_G[i]),
            .Po(l8_P[i]));
    end else begin
        assign l8_G[i]=l7_G[i];
        assign l8_P[i]=l7_P[i];
    end
end
endgenerate

// Level 9
// Generate and Propagate signal wires
wire [31:0] l9_G;
wire [31:0] l9_P;

// generate filled black squares
generate
for(i = 0; i<32; i = i+1) begin: gen_l9
    if ((i%2==0)&&(i>=2)) begin
        op_o u_op_o(
            .Gh(l8_G[i]),
            .Ph(l8_P[i]),
            .Gl(l8_G[i-1]),
            .Pl(l8_P[i-1]),
            .Go(l9_G[i]),
            .Po(l9_P[i]));
    end else begin
        assign l9_G[i]=l8_G[i];
        assign l9_P[i]=l8_P[i];
    end
end
endgenerate

assign Carry=l9_G[31:0];

endmodule