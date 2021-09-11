/*
 This module implements the precomputation module in prefix adder
 it takes the two operand A and B to generate the first level Generate and Propagate signals:
 . G = A & B;
 . P = A ^ B;
 */
module pg_gen (input A,
               input B,
               output G,
               output P);
    and and0(G,A,B);
    xor xor0(P,A,B);
endmodule
