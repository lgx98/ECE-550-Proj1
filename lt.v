/*
 this module checks if A<B using the result of A-B
 */
module lt (input sub_sign_bit,
           input ovf,
           output out);
    xor xor0(out,sub_sign_bit,ovf);
endmodule
