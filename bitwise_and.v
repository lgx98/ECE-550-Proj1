/*
 this module implements bitwise AND operation for 32 bit vectors
 assign out = inA & inB;
 */
module bitwise_and (input [31:0] inA,
                    input [31:0] inB,
                    output [31:0] out);						  
		genvar i;
		generate 						  
		for(i=0; i<32; i = i+1) begin: gen_bitwise_and
		and u_and (out[i], inA[i], inB[i]);					  
		end						  
		endgenerate
endmodule
