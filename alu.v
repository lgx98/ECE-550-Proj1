module alu(
   data_operandA,
   data_operandB,
   ctrl_ALUopcode,
   ctrl_shiftamt,
   data_result,
   isNotEqual,
   isLessThan,
   overflow);
   
   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
   wire [31:0] addsub_result, bitwise_and_result, bitwise_or_result, sll_result, sra_result;

   wire ovf;
   addsub addsub0(
      .inA(data_operandA),
      .inB(data_operandB),
      .EN_SUB(ctrl_ALUopcode[0]),
      .out(addsub_result),
      .overflow(ovf));
   
   bitwise_and bitwise_and0(
      .inA(data_operandA),
      .inB(data_operandB),
      .out(bitwise_and_result));
   
   bitwise_or bitwise_or0(
      .inA(data_operandA),
      .inB(data_operandB),
      .out(bitwise_or_result));

   sll sll0(
      .in(data_operandA),
      .offset(ctrl_shiftamt),
      .out(sll_result));

   sra sra0(
      .in(data_operandA),
      .offset(ctrl_shiftamt),
      .out(sra_result));
   
   ne ne0(
      .inA(data_operandA),
      .inB(data_operandB),
      .out(isNotEqual));

   lt lt0(
      .sub_sign_bit(addsub_result[31]),
      .ovf(ovf),
      .out(isLessThan));

   assign data_result = 
   ctrl_ALUopcode[4]==0?
      ctrl_ALUopcode[3]==0? // 0xxxx
         ctrl_ALUopcode[2]==0? // 00xxx
            ctrl_ALUopcode[1]==0? // 000xx
               addsub_result // 0000x
            :
               ctrl_ALUopcode[0]==0? // 0001x
                  bitwise_and_result // 00010
               :
                  bitwise_or_result // 00011
         :
            ctrl_ALUopcode[1]==0? // 001xx
               ctrl_ALUopcode[0]==0? // 0010x
                  sll_result // 00100
               :
                  sra_result // 00101
            :
               32'h00000000 // 0011x
      :
         32'h00000000 // 01xxxx
   :
      32'h00000000; // 1xxxxx

   assign overflow = ovf;
    
endmodule
