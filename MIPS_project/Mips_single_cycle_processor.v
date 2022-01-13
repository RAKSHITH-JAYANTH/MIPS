
module binary_0_6 (output wire [0:5] out);
assign out =6'b 0;
endmodule

module binary_100011_6 (output wire [0:5] out);
assign out =6'b 100011;
endmodule

module binary_101011_6 (output wire [0:5] out);
assign out =6'b 101011;
endmodule

module binary_100_6 (output wire [0:5] out);
assign out =6'b 100;
endmodule

module binary_1000_6 (output wire [0:5] out);
assign out =6'b 1000;
endmodule

module gate_xnor2inv (input wire  i0, i1, output wire  o);
  assign o = i0 ^ i1;
endmodule

module gate_invert (input wire  i, output wire  o);
  assign o = !i;
endmodule

module gate_and2 (input wire  i0, i1, output wire  o);
  assign o = i0 & i1;
endmodule

module gate_or2 (input wire  i0, i1, output wire  o);
  assign o = i0 | i1;
endmodule

module id (input wire  i, output wire  o);
 assign o = i;
endmodule

module df (input wire  clk, in, output wire  out);
reg df_out;
initial df_out=0;
always@(posedge clk) df_out <= in;
assign out = df_out;
endmodule

module instruction_memory_32_32 (input wire  clk, reset, wen, input wire [0:31] din, r_addr, w_addr, output wire [0:31] r_out);
 wire [0:31] wa, ra; reg [0:31] _wa, _ra; wire [0:31] wi;
 reg [0:31] ram [0:31];
 integer i;
 initial begin
   for(i = 0;i < 32;i=i+1) ram[i] = 0;
   ram[32'h0]=32'h0;
 end
 always @(posedge clk) begin if (wen) ram[wa] <= wi; _wa<=wa; end
 assign wa = w_addr[0:31];
 assign ra = r_addr[0:31];
 assign wi = din[0:31];
 assign r_out[0:31] = ram [r_addr];
endmodule

module register_file_32_32 (input wire  clk, reset, wen, input wire [0:31] din, input wire [0:4] w_addr, r_addr1, r_addr2, output wire [0:31] r_out1, r_out2);
 wire [0:4] wa, ra1, ra2; reg [0:4] _wa, _ra1, _ra2; wire [0:31] wi;
 reg [0:31] ram [0:31];
 integer i;
 initial begin
   for(i = 0;i < 32;i=i+1) ram[i] = 0;
   ram[5'h0]=32'h0;
 end
 always @(posedge clk) begin if (wen) ram[wa] <= wi; _wa<=wa; end
 assign wa = w_addr[0:4];
 assign ra1 = r_addr1[0:4];
 assign ra2 = r_addr2[0:4];
 assign wi = din[0:31];
 assign r_out1[0:31] = ram [r_addr1];
 assign r_out2[0:31] = ram[r_addr2];
endmodule

module zero (output wire  o);
 assign o = 1'b0;
endmodule

module fa (input wire  i0, i1, cin, output wire  sum, cout);
  assign sum=i0^i1^cin; assign cout=(i0 & i1)|(i1 & cin)|(cin & i0);
endmodule

module mux_32_2 (input wire [0:31] i0, i1, input wire  sel, output wire [0:31] o);
assign o = sel == 0? i0:i1;
endmodule

module data_memory_32_32 (input wire  clk, reset, wen, input wire [0:31] din, addr, output wire [0:31] r_out);
 wire [0:31] wa, ra; reg [0:31] _wa, _ra; wire [0:31] wi;
 reg [0:31] ram [0:31];
 integer i;
 initial begin
   for(i = 0;i < 32;i=i+1) ram[i] = 0;
   ram[32'h0]=32'h0;
 end
 always @(posedge clk) begin if (wen) ram[wa] <= wi; _wa<=wa; end
 assign wa = addr[0:31];
 assign ra = addr[0:31];
 assign wi = din[0:31];
 assign r_out[0:31] = ram [addr];
endmodule

module d_b_1_32 (output wire [0:31] out);
assign out =32'd 1;
endmodule

module mux_5_2 (input wire [0:4] i0, i1, input wire  sel, output wire [0:4] o);
assign o = sel == 0? i0:i1;
endmodule

module MIPS_Single_Cycle_Processor (input wire  clk, reset, input wire [0:31] instruction, instruct_addr, input wire  wr_inst);
  wire  alu_src, branch, mem_to_reg, mem_write, reg_dest, reg_write;
  wire [0:2] alu_control;
  wire [0:5] funct, op_code;
  control_logic_single_cycle control_logic_single_cycle_0(op_code, funct, mem_to_reg, mem_write, branch, alu_src, reg_dest, reg_write, alu_control);
  data_path_single_cycle data_path_single_cycle_1(clk, reset, instruction, instruct_addr, wr_inst, mem_to_reg, mem_write, branch, alu_src, reg_dest, reg_write, alu_control, funct, op_code);
endmodule

module control_logic_single_cycle (input wire [0:5] op_code, funct, output wire  mem_to_reg, mem_write, branch, alu_src, reg_dest, reg_write, output wire [0:2] alu_control);
  wire [0:1] alu_op;
  main_decoder_single_cycle main_decoder_single_cycle_0(op_code, mem_to_reg, mem_write, branch, alu_src, reg_dest, reg_write, alu_op);
  alu_decoder_single_cycle alu_decoder_single_cycle_1(funct, alu_op, alu_control);
endmodule

module main_decoder_single_cycle (input wire [0:5] op_code, output wire  mem_to_reg, mem_write, branch, alu_src, reg_dest, reg_write, output wire [0:1] alu_op);
  wire  is_equal_addi, is_equal_beq, is_equal_lw, is_equal_r_type, is_equal_sw;
  wire [0:5] addi, beq, lw, r_type, sw;
  binary_0_6 binary_0_6_0(r_type);
  binary_100011_6 binary_100011_6_1(lw);
  binary_101011_6 binary_101011_6_2(sw);
  binary_100_6 binary_100_6_3(beq);
  binary_1000_6 binary_1000_6_4(addi);
  comparator_6 comparator_6_5(op_code, r_type, is_equal_r_type);
  comparator_6 comparator_6_6(op_code, lw, is_equal_lw);
  comparator_6 comparator_6_7(op_code, sw, is_equal_sw);
  comparator_6 comparator_6_8(op_code, beq, is_equal_beq);
  comparator_6 comparator_6_9(op_code, addi, is_equal_addi);
  gate_or_3 gate_or_3_10(is_equal_r_type, is_equal_lw, is_equal_addi, reg_write);
  id id_11(is_equal_r_type, reg_dest);
  gate_or_3 gate_or_3_12(is_equal_lw, is_equal_sw, is_equal_addi, alu_src);
  id id_13(is_equal_beq, branch);
  id id_14(is_equal_sw, mem_write);
  id id_15(is_equal_lw, mem_to_reg);
  id id_16(is_equal_r_type, alu_op[0]);
  id id_17(is_equal_beq, alu_op[1]);
endmodule

module comparator_6 (input wire [0:5] i0, i1, output wire  op);
  wire  o;
  gate_xnor2 gate_xnor2_0(i0[0], i1[0], o);
  comparator_unit_5 comparator_unit_5_1(o, i0[1:5], i1[1:5], op);
endmodule

module gate_xnor2 (input wire  i0, i1, output wire  o);
  wire  _t;
  gate_xnor2inv gate_xnor2inv_0(i0, i1, _t);
  gate_invert gate_invert_1(_t, o);
endmodule

module comparator_unit_5 (input wire  i, input wire [0:4] i0, i1, output wire  o);
  wire [0:3] _i, _o;
  comparator_unit comparator_unit_0(i, i0[0], i1[0], _o[0]);
  id_1 id_1_1(_o[0], _i[0]);
  comparator_unit comparator_unit_2(_i[0], i0[1], i1[1], _o[1]);
  id_1 id_1_3(_o[1], _i[1]);
  comparator_unit comparator_unit_4(_i[1], i0[2], i1[2], _o[2]);
  id_1 id_1_5(_o[2], _i[2]);
  comparator_unit comparator_unit_6(_i[2], i0[3], i1[3], _o[3]);
  id_1 id_1_7(_o[3], _i[3]);
  comparator_unit comparator_unit_8(_i[3], i0[4], i1[4], o);
endmodule

module comparator_unit (input wire  i, i0, i1, output wire  o);
  wire  _o;
  gate_xnor2 gate_xnor2_0(i0, i1, _o);
  gate_and2 gate_and2_1(_o, i, o);
endmodule

module id_1 (input wire  i, output wire  o);
  id id_0(i, o);
endmodule

module gate_or_3 (input wire  a, b, c, output wire  out);
  wire  t1;
  gate_or2 gate_or2_0(a, b, t1);
  gate_or2 gate_or2_1(t1, c, out);
endmodule

module alu_decoder_single_cycle (input wire [0:5] funct, input wire [0:1] alu_op, output wire [0:2] alu_control);
  wire  _a1, _a2, _f1, _f2, _f3, _f4, _f5, _f6, a1, a2, f1, f2, f3, f4, f5, f6, t1, t2, t3, t4, t5, t6, t7, t8, t9;
  id id_0(alu_op[0], a1);
  id id_1(alu_op[1], a2);
  id id_2(funct[0], f1);
  id id_3(funct[1], f2);
  id id_4(funct[2], f3);
  id id_5(funct[3], f4);
  id id_6(funct[4], f5);
  id id_7(funct[5], f6);
  gate_invert gate_invert_8(a1, _a1);
  gate_invert gate_invert_9(a2, _a2);
  gate_invert gate_invert_10(f1, _f1);
  gate_invert gate_invert_11(f2, _f2);
  gate_invert gate_invert_12(f3, _f3);
  gate_invert gate_invert_13(f4, _f4);
  gate_invert gate_invert_14(f5, _f5);
  gate_invert gate_invert_15(f6, _f6);
  gate_and_6 gate_and_6_16(a1, f1, _f2, _f4, f5, _f6, t1);
  gate_or2 gate_or2_17(t1, a2, alu_control[0]);
  gate_and2 gate_and2_18(f3, f5, t2);
  gate_or2 gate_or2_19(_f3, t2, t3);
  gate_and_6 gate_and_6_20(_f2, f3, _f4, f5, _f6, t3, t4);
  gate_and2 gate_and2_21(_a1, _a2, t5);
  gate_or2 gate_or2_22(t5, a2, t6);
  gate_or2 gate_or2_23(t4, t6, alu_control[1]);
  gate_and_4 gate_and_4_24(_f3, f4, _f5, f6, t7);
  gate_and_4 gate_and_4_25(f3, _f4, f5, _f6, t8);
  gate_or2 gate_or2_26(t7, t8, t9);
  gate_and_4 gate_and_4_27(a1, f1, _f2, t9, alu_control[2]);
endmodule

module gate_and_6 (input wire  a, b, c, d, e, f, output wire  out);
  wire  t1, t2, t3, t4;
  gate_and2 gate_and2_0(a, b, t1);
  gate_and2 gate_and2_1(c, d, t2);
  gate_and2 gate_and2_2(e, f, t3);
  gate_and2 gate_and2_3(t1, t2, t4);
  gate_and2 gate_and2_4(t4, t3, out);
endmodule

module gate_and_4 (input wire  a, b, c, d, output wire  out);
  wire  t1, t2;
  gate_and2 gate_and2_0(a, b, t1);
  gate_and2 gate_and2_1(c, d, t2);
  gate_and2 gate_and2_2(t1, t2, out);
endmodule

module data_path_single_cycle (input wire  clk, reset, input wire [0:31] instruction, instruct_addr, input wire  wr_inst, mem_to_reg, mem_write, branch, alu_src, reg_dest, reg_write, input wire [0:2] alu_control, output wire [0:5] funct, op_code);
  wire  pc_src, zero;
  wire [0:4] write_reg;
  wire [0:31] alu_result, instr, one, out_addr, pc_branch, pc_plus_1, pc_prime, rd2, read_data, result, sign_imm, srcA, srcB;
  program_counter_32 program_counter_32_0(clk, reset, pc_prime, out_addr);
  instruction_memory_32_32 instruction_memory_32_32_1(clk, reset, wr_inst, instruction, out_addr, instruct_addr, instr);
  register_file_32_32 register_file_32_32_2(clk, reset, reg_write, result, write_reg, instr[6:10], instr[11:15], srcA, rd2);
  alu_32 alu_32_3(srcA, srcB, alu_control, alu_result, zero);
  data_memory_32_32 data_memory_32_32_4(clk, reset, mem_write, rd2, alu_result, read_data);
  sign_extend_16_32 sign_extend_16_32_5(instr[16:31], sign_imm);
  adder_32 adder_32_6(sign_imm, pc_plus_1, pc_branch);
  d_b_1_32 d_b_1_32_7(one);
  adder_32 adder_32_8(out_addr, one, pc_plus_1);
  mux_32_2 mux_32_2_9(pc_plus_1, pc_branch, pc_src, pc_prime);
  mux_32_2 mux_32_2_10(rd2, sign_imm, alu_src, srcB);
  mux_32_2 mux_32_2_11(alu_result, read_data, mem_to_reg, result);
  mux_5_2 mux_5_2_12(instr[11:15], instr[16:20], reg_dest, write_reg);
  gate_and2 gate_and2_13(branch, zero, pc_src);
  id_6id_6 id_6id_6_14(instr[26:31], funct);
  id_6id_6 id_6id_6_15(instr[0:5], op_code);
endmodule

module program_counter_32 (input wire  clk, reset, input wire [0:31] in_addr, output wire [0:31] out_addr);
  dfr_32 dfr_32_0(clk, reset, in_addr, out_addr);
endmodule

module dfr_32 (input wire  clk, reset, input wire [0:31] in, output wire [0:31] out);
  dfr dfr_0(clk, reset, in[0], out[0]);
  dfr dfr_1(clk, reset, in[1], out[1]);
  dfr dfr_2(clk, reset, in[2], out[2]);
  dfr dfr_3(clk, reset, in[3], out[3]);
  dfr dfr_4(clk, reset, in[4], out[4]);
  dfr dfr_5(clk, reset, in[5], out[5]);
  dfr dfr_6(clk, reset, in[6], out[6]);
  dfr dfr_7(clk, reset, in[7], out[7]);
  dfr dfr_8(clk, reset, in[8], out[8]);
  dfr dfr_9(clk, reset, in[9], out[9]);
  dfr dfr_10(clk, reset, in[10], out[10]);
  dfr dfr_11(clk, reset, in[11], out[11]);
  dfr dfr_12(clk, reset, in[12], out[12]);
  dfr dfr_13(clk, reset, in[13], out[13]);
  dfr dfr_14(clk, reset, in[14], out[14]);
  dfr dfr_15(clk, reset, in[15], out[15]);
  dfr dfr_16(clk, reset, in[16], out[16]);
  dfr dfr_17(clk, reset, in[17], out[17]);
  dfr dfr_18(clk, reset, in[18], out[18]);
  dfr dfr_19(clk, reset, in[19], out[19]);
  dfr dfr_20(clk, reset, in[20], out[20]);
  dfr dfr_21(clk, reset, in[21], out[21]);
  dfr dfr_22(clk, reset, in[22], out[22]);
  dfr dfr_23(clk, reset, in[23], out[23]);
  dfr dfr_24(clk, reset, in[24], out[24]);
  dfr dfr_25(clk, reset, in[25], out[25]);
  dfr dfr_26(clk, reset, in[26], out[26]);
  dfr dfr_27(clk, reset, in[27], out[27]);
  dfr dfr_28(clk, reset, in[28], out[28]);
  dfr dfr_29(clk, reset, in[29], out[29]);
  dfr dfr_30(clk, reset, in[30], out[30]);
  dfr dfr_31(clk, reset, in[31], out[31]);
endmodule

module dfr (input wire  clk, reset, in, output wire  out);
  wire  df_in, reset_;
  gate_invert gate_invert_0(reset, reset_);
  gate_and2 gate_and2_1(in, reset_, df_in);
  df df_2(clk, df_in, out);
endmodule

module alu_32 (input wire [0:31] srcA, srcB, input wire [0:2] alu_control, output wire [0:31] alu_result, output wire  zero);
  wire [0:31] add_res, z;
  adder_32 adder_32_0(srcA, srcB, add_res);
  zero zero_1(z[0]);
  mux_32_8 mux_32_8_2(add_res, z, z, z, z, z, z, z, alu_control, alu_result);
  comparator_32 comparator_32_3(alu_result, z, zero);
endmodule

module adder_32 (input wire [0:31] i1, i2, output wire [0:31] out);
  wire  c0, cout;
  zero zero_0(c0);
  fa_32 fa_32_1(i1, i2, c0, out, cout);
endmodule

module fa_32 (input wire [0:31] i0, i1, input wire  cin, output wire [0:31] sum, output wire  cout);
  wire [0:30] _cin, _cout;
  fa fa_0(i0[0], i1[0], cin, sum[0], _cout[0]);
  id_1 id_1_1(_cout[0], _cin[0]);
  fa fa_2(i0[1], i1[1], _cin[0], sum[1], _cout[1]);
  id_1 id_1_3(_cout[1], _cin[1]);
  fa fa_4(i0[2], i1[2], _cin[1], sum[2], _cout[2]);
  id_1 id_1_5(_cout[2], _cin[2]);
  fa fa_6(i0[3], i1[3], _cin[2], sum[3], _cout[3]);
  id_1 id_1_7(_cout[3], _cin[3]);
  fa fa_8(i0[4], i1[4], _cin[3], sum[4], _cout[4]);
  id_1 id_1_9(_cout[4], _cin[4]);
  fa fa_10(i0[5], i1[5], _cin[4], sum[5], _cout[5]);
  id_1 id_1_11(_cout[5], _cin[5]);
  fa fa_12(i0[6], i1[6], _cin[5], sum[6], _cout[6]);
  id_1 id_1_13(_cout[6], _cin[6]);
  fa fa_14(i0[7], i1[7], _cin[6], sum[7], _cout[7]);
  id_1 id_1_15(_cout[7], _cin[7]);
  fa fa_16(i0[8], i1[8], _cin[7], sum[8], _cout[8]);
  id_1 id_1_17(_cout[8], _cin[8]);
  fa fa_18(i0[9], i1[9], _cin[8], sum[9], _cout[9]);
  id_1 id_1_19(_cout[9], _cin[9]);
  fa fa_20(i0[10], i1[10], _cin[9], sum[10], _cout[10]);
  id_1 id_1_21(_cout[10], _cin[10]);
  fa fa_22(i0[11], i1[11], _cin[10], sum[11], _cout[11]);
  id_1 id_1_23(_cout[11], _cin[11]);
  fa fa_24(i0[12], i1[12], _cin[11], sum[12], _cout[12]);
  id_1 id_1_25(_cout[12], _cin[12]);
  fa fa_26(i0[13], i1[13], _cin[12], sum[13], _cout[13]);
  id_1 id_1_27(_cout[13], _cin[13]);
  fa fa_28(i0[14], i1[14], _cin[13], sum[14], _cout[14]);
  id_1 id_1_29(_cout[14], _cin[14]);
  fa fa_30(i0[15], i1[15], _cin[14], sum[15], _cout[15]);
  id_1 id_1_31(_cout[15], _cin[15]);
  fa fa_32(i0[16], i1[16], _cin[15], sum[16], _cout[16]);
  id_1 id_1_33(_cout[16], _cin[16]);
  fa fa_34(i0[17], i1[17], _cin[16], sum[17], _cout[17]);
  id_1 id_1_35(_cout[17], _cin[17]);
  fa fa_36(i0[18], i1[18], _cin[17], sum[18], _cout[18]);
  id_1 id_1_37(_cout[18], _cin[18]);
  fa fa_38(i0[19], i1[19], _cin[18], sum[19], _cout[19]);
  id_1 id_1_39(_cout[19], _cin[19]);
  fa fa_40(i0[20], i1[20], _cin[19], sum[20], _cout[20]);
  id_1 id_1_41(_cout[20], _cin[20]);
  fa fa_42(i0[21], i1[21], _cin[20], sum[21], _cout[21]);
  id_1 id_1_43(_cout[21], _cin[21]);
  fa fa_44(i0[22], i1[22], _cin[21], sum[22], _cout[22]);
  id_1 id_1_45(_cout[22], _cin[22]);
  fa fa_46(i0[23], i1[23], _cin[22], sum[23], _cout[23]);
  id_1 id_1_47(_cout[23], _cin[23]);
  fa fa_48(i0[24], i1[24], _cin[23], sum[24], _cout[24]);
  id_1 id_1_49(_cout[24], _cin[24]);
  fa fa_50(i0[25], i1[25], _cin[24], sum[25], _cout[25]);
  id_1 id_1_51(_cout[25], _cin[25]);
  fa fa_52(i0[26], i1[26], _cin[25], sum[26], _cout[26]);
  id_1 id_1_53(_cout[26], _cin[26]);
  fa fa_54(i0[27], i1[27], _cin[26], sum[27], _cout[27]);
  id_1 id_1_55(_cout[27], _cin[27]);
  fa fa_56(i0[28], i1[28], _cin[27], sum[28], _cout[28]);
  id_1 id_1_57(_cout[28], _cin[28]);
  fa fa_58(i0[29], i1[29], _cin[28], sum[29], _cout[29]);
  id_1 id_1_59(_cout[29], _cin[29]);
  fa fa_60(i0[30], i1[30], _cin[29], sum[30], _cout[30]);
  id_1 id_1_61(_cout[30], _cin[30]);
  fa fa_62(i0[31], i1[31], _cin[30], sum[31], cout);
endmodule

module mux_32_8 (input wire [0:31] i0, i1, i2, i3, i4, i5, i6, i7, input wire [0:2] sel, output wire [0:31] out);
  wire [0:31] t1, t2, t3, t4, t5, t6;
  mux_32_2 mux_32_2_0(i0, i1, sel[0], t1);
  mux_32_2 mux_32_2_1(i2, i3, sel[0], t2);
  mux_32_2 mux_32_2_2(i4, i5, sel[0], t3);
  mux_32_2 mux_32_2_3(i6, i7, sel[0], t4);
  mux_32_2 mux_32_2_4(t1, t2, sel[1], t5);
  mux_32_2 mux_32_2_5(t3, t4, sel[1], t6);
  mux_32_2 mux_32_2_6(t5, t6, sel[2], out);
endmodule

module comparator_32 (input wire [0:31] i0, i1, output wire  op);
  wire  o;
  gate_xnor2 gate_xnor2_0(i0[0], i1[0], o);
  comparator_unit_31 comparator_unit_31_1(o, i0[1:31], i1[1:31], op);
endmodule

module comparator_unit_31 (input wire  i, input wire [0:30] i0, i1, output wire  o);
  wire [0:29] _i, _o;
  comparator_unit comparator_unit_0(i, i0[0], i1[0], _o[0]);
  id_1 id_1_1(_o[0], _i[0]);
  comparator_unit comparator_unit_2(_i[0], i0[1], i1[1], _o[1]);
  id_1 id_1_3(_o[1], _i[1]);
  comparator_unit comparator_unit_4(_i[1], i0[2], i1[2], _o[2]);
  id_1 id_1_5(_o[2], _i[2]);
  comparator_unit comparator_unit_6(_i[2], i0[3], i1[3], _o[3]);
  id_1 id_1_7(_o[3], _i[3]);
  comparator_unit comparator_unit_8(_i[3], i0[4], i1[4], _o[4]);
  id_1 id_1_9(_o[4], _i[4]);
  comparator_unit comparator_unit_10(_i[4], i0[5], i1[5], _o[5]);
  id_1 id_1_11(_o[5], _i[5]);
  comparator_unit comparator_unit_12(_i[5], i0[6], i1[6], _o[6]);
  id_1 id_1_13(_o[6], _i[6]);
  comparator_unit comparator_unit_14(_i[6], i0[7], i1[7], _o[7]);
  id_1 id_1_15(_o[7], _i[7]);
  comparator_unit comparator_unit_16(_i[7], i0[8], i1[8], _o[8]);
  id_1 id_1_17(_o[8], _i[8]);
  comparator_unit comparator_unit_18(_i[8], i0[9], i1[9], _o[9]);
  id_1 id_1_19(_o[9], _i[9]);
  comparator_unit comparator_unit_20(_i[9], i0[10], i1[10], _o[10]);
  id_1 id_1_21(_o[10], _i[10]);
  comparator_unit comparator_unit_22(_i[10], i0[11], i1[11], _o[11]);
  id_1 id_1_23(_o[11], _i[11]);
  comparator_unit comparator_unit_24(_i[11], i0[12], i1[12], _o[12]);
  id_1 id_1_25(_o[12], _i[12]);
  comparator_unit comparator_unit_26(_i[12], i0[13], i1[13], _o[13]);
  id_1 id_1_27(_o[13], _i[13]);
  comparator_unit comparator_unit_28(_i[13], i0[14], i1[14], _o[14]);
  id_1 id_1_29(_o[14], _i[14]);
  comparator_unit comparator_unit_30(_i[14], i0[15], i1[15], _o[15]);
  id_1 id_1_31(_o[15], _i[15]);
  comparator_unit comparator_unit_32(_i[15], i0[16], i1[16], _o[16]);
  id_1 id_1_33(_o[16], _i[16]);
  comparator_unit comparator_unit_34(_i[16], i0[17], i1[17], _o[17]);
  id_1 id_1_35(_o[17], _i[17]);
  comparator_unit comparator_unit_36(_i[17], i0[18], i1[18], _o[18]);
  id_1 id_1_37(_o[18], _i[18]);
  comparator_unit comparator_unit_38(_i[18], i0[19], i1[19], _o[19]);
  id_1 id_1_39(_o[19], _i[19]);
  comparator_unit comparator_unit_40(_i[19], i0[20], i1[20], _o[20]);
  id_1 id_1_41(_o[20], _i[20]);
  comparator_unit comparator_unit_42(_i[20], i0[21], i1[21], _o[21]);
  id_1 id_1_43(_o[21], _i[21]);
  comparator_unit comparator_unit_44(_i[21], i0[22], i1[22], _o[22]);
  id_1 id_1_45(_o[22], _i[22]);
  comparator_unit comparator_unit_46(_i[22], i0[23], i1[23], _o[23]);
  id_1 id_1_47(_o[23], _i[23]);
  comparator_unit comparator_unit_48(_i[23], i0[24], i1[24], _o[24]);
  id_1 id_1_49(_o[24], _i[24]);
  comparator_unit comparator_unit_50(_i[24], i0[25], i1[25], _o[25]);
  id_1 id_1_51(_o[25], _i[25]);
  comparator_unit comparator_unit_52(_i[25], i0[26], i1[26], _o[26]);
  id_1 id_1_53(_o[26], _i[26]);
  comparator_unit comparator_unit_54(_i[26], i0[27], i1[27], _o[27]);
  id_1 id_1_55(_o[27], _i[27]);
  comparator_unit comparator_unit_56(_i[27], i0[28], i1[28], _o[28]);
  id_1 id_1_57(_o[28], _i[28]);
  comparator_unit comparator_unit_58(_i[28], i0[29], i1[29], _o[29]);
  id_1 id_1_59(_o[29], _i[29]);
  comparator_unit comparator_unit_60(_i[29], i0[30], i1[30], o);
endmodule

module sign_extend_16_32 (input wire [0:15] i, output wire [0:31] o);
  wire  msb;
  id_16 id_16_0(i, o[16:31]);
  id id_1(i[15], msb);
  __16id_16 __16id_16_2(msb, o[0:15]);
endmodule

module id_16 (input wire [0:15] i, output wire [0:15] o);
  id id_0(i[0], o[0]);
  id id_1(i[1], o[1]);
  id id_2(i[2], o[2]);
  id id_3(i[3], o[3]);
  id id_4(i[4], o[4]);
  id id_5(i[5], o[5]);
  id id_6(i[6], o[6]);
  id id_7(i[7], o[7]);
  id id_8(i[8], o[8]);
  id id_9(i[9], o[9]);
  id id_10(i[10], o[10]);
  id id_11(i[11], o[11]);
  id id_12(i[12], o[12]);
  id id_13(i[13], o[13]);
  id id_14(i[14], o[14]);
  id id_15(i[15], o[15]);
endmodule

module __16id_16 (input wire  i, output wire [0:15] o);
  id id_0(i, o[0]);
  id id_1(i, o[1]);
  id id_2(i, o[2]);
  id id_3(i, o[3]);
  id id_4(i, o[4]);
  id id_5(i, o[5]);
  id id_6(i, o[6]);
  id id_7(i, o[7]);
  id id_8(i, o[8]);
  id id_9(i, o[9]);
  id id_10(i, o[10]);
  id id_11(i, o[11]);
  id id_12(i, o[12]);
  id id_13(i, o[13]);
  id id_14(i, o[14]);
  id id_15(i, o[15]);
endmodule

module id_6id_6 (input wire [0:5] i, output wire [0:5] o);
  id id_0(i[0], o[0]);
  id id_1(i[1], o[1]);
  id id_2(i[2], o[2]);
  id id_3(i[3], o[3]);
  id id_4(i[4], o[4]);
  id id_5(i[5], o[5]);
endmodule
