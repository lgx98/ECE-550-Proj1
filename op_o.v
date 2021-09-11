/*
 This module implements the "o" operation in prefix carry aggregation, which is often shown as a filled black square in diagrams
 it takes two pairs of Generate and Propagate signals and outputs the aggregated pair
 (Go, Po) = (Gh, Ph) o (Gl, Pl), where:
 . Go = Gh |(Gl & Ph)
 . Po = Ph & Pl
 
 the "o" operation has the following properties:
 . (X3 o X2) o X1 = X3 o (X2 o X1)
 . (X2 o X1) o X1 = X2 o X1
 . (X2 o X1) o X2 = X2 o X1
 
 which makes it possible to design tree-like carry generation networks using partial results
 */
module op_o (input Gh,
             inout Ph,
             input Gl,
             input Pl,
             output Go,
             output Po);
    wire a0;
    and and0(a0,Gl,Ph);
    and and1(Po,Ph,Pl);
    or or0(Go,a0,Gh);
endmodule
