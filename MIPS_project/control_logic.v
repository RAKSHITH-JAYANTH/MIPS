
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
