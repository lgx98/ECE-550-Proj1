/*
 this module implements the carry generation network of a Sklansky adder[1].
 
 Reference:
 [1] J. Sklansky, "Conditional-Sum Addition Logic," in IRE Transactions on Electronic Computers, vol. EC-9, no. 2, pp. 226-231, June 1960, doi: 10.1109/TEC.1960.5219822.
 */
module prefix_network_SK (
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
    if ((i/1)%2) begin
        op_o u_op_o(
            .Gh(l0_G[i]),
            .Ph(l0_P[i]),
            .Gl(l0_G[(i|1)-1]),
            .Pl(l0_P[(i|1)-1]),
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
    if ((i/2)%2) begin
        op_o u_op_o(
            .Gh(l1_G[i]),
            .Ph(l1_P[i]),
            .Gl(l1_G[(i|3)-2]),
            .Pl(l1_P[(i|3)-2]),
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
    if ((i/4)%2) begin
        op_o u_op_o(
            .Gh(l2_G[i]),
            .Ph(l2_P[i]),
            .Gl(l2_G[(i|7)-4]),
            .Pl(l2_P[(i|7)-4]),
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
    if ((i/8)%2) begin
        op_o u_op_o(
            .Gh(l3_G[i]),
            .Ph(l3_P[i]),
            .Gl(l3_G[(i|15)-8]),
            .Pl(l3_P[(i|15)-8]),
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
    if ((i/16)%2) begin
        op_o u_op_o(
            .Gh(l4_G[i]),
            .Ph(l4_P[i]),
            .Gl(l4_G[(i|31)-16]),
            .Pl(l4_P[(i|31)-16]),
            .Go(l5_G[i]),
            .Po(l5_P[i]));
    end else begin
        assign l5_G[i]=l4_G[i];
        assign l5_P[i]=l4_P[i];
    end
end
endgenerate

assign Carry=l5_G[31:0];

endmodule