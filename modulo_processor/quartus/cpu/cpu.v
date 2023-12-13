// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Wed Dec 13 02:37:19 2023"

module cpu(
	clk,
	rst,
	fetch_instr,
	read_enable,
	write_enable,
	addr,
	addr_mem,
	data_out,
	RFlags
);


input wire	clk;
input wire	rst;
input wire	[31:0] fetch_instr;
output wire	read_enable;
output wire	write_enable;
output wire	[14:0] addr;
output wire	[14:0] addr_mem;
output wire	[31:0] data_out;
output wire	[4:0] RFlags;

wire	SYNTHESIZED_WIRE_51;
wire	[14:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_52;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[14:0] SYNTHESIZED_WIRE_8;
wire	[31:0] SYNTHESIZED_WIRE_53;
wire	[31:0] SYNTHESIZED_WIRE_54;
wire	[31:0] SYNTHESIZED_WIRE_55;
wire	[31:0] SYNTHESIZED_WIRE_56;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[31:0] SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	[31:0] SYNTHESIZED_WIRE_23;
wire	[31:0] SYNTHESIZED_WIRE_25;
wire	[14:0] SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_57;
wire	SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_34;
wire	[4:0] SYNTHESIZED_WIRE_35;
wire	[4:0] SYNTHESIZED_WIRE_36;
wire	[31:0] SYNTHESIZED_WIRE_37;
wire	[31:0] SYNTHESIZED_WIRE_58;
wire	[31:0] SYNTHESIZED_WIRE_40;
wire	[31:0] SYNTHESIZED_WIRE_42;
wire	[31:0] SYNTHESIZED_WIRE_59;
wire	[31:0] SYNTHESIZED_WIRE_60;
wire	[31:0] SYNTHESIZED_WIRE_45;
wire	[31:0] SYNTHESIZED_WIRE_48;
wire	[31:0] SYNTHESIZED_WIRE_50;

assign	addr_mem = SYNTHESIZED_WIRE_8;
assign	data_out = SYNTHESIZED_WIRE_48;




decode	b2v_decode(
	.clk(clk),
	.rst(SYNTHESIZED_WIRE_51),
	.addr(SYNTHESIZED_WIRE_1),
	.immed(SYNTHESIZED_WIRE_2),
	.inst(SYNTHESIZED_WIRE_52),
	.Rd1(SYNTHESIZED_WIRE_4),
	.Rd2(SYNTHESIZED_WIRE_5),
	.stored_addr(SYNTHESIZED_WIRE_28),
	.stored_immed(SYNTHESIZED_WIRE_54),
	.stored_inst(SYNTHESIZED_WIRE_53),
	.stored_Rd1(SYNTHESIZED_WIRE_55),
	.stored_Rd2(SYNTHESIZED_WIRE_56));
	defparam	b2v_decode.AWIDTH = 15;
	defparam	b2v_decode.DWIDTH = 32;


extensor	b2v_extensor(
	.instruction(SYNTHESIZED_WIRE_52),
	.immediate(SYNTHESIZED_WIRE_2));


fetch	b2v_fetch(
	.clk(clk),
	.rst(SYNTHESIZED_WIRE_51),
	.fetch_addr(SYNTHESIZED_WIRE_8),
	.fetch_instr(fetch_instr),
	.fetched_addr(SYNTHESIZED_WIRE_1),
	.fetched_instr(SYNTHESIZED_WIRE_52));
	defparam	b2v_fetch.AWIDTH = 15;
	defparam	b2v_fetch.DWIDTH = 32;


muxula	b2v_inst(
	.alu_instr(SYNTHESIZED_WIRE_53),
	.immed(SYNTHESIZED_WIRE_54),
	.Rd1(SYNTHESIZED_WIRE_55),
	.Rd2(SYNTHESIZED_WIRE_56),
	.operand_a(SYNTHESIZED_WIRE_13),
	.operand_b(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst.DWIDTH = 32;


ula	b2v_inst11(
	.operand_a(SYNTHESIZED_WIRE_13),
	.operand_b(SYNTHESIZED_WIRE_14),
	.ula_instr(SYNTHESIZED_WIRE_53),
	.below(SYNTHESIZED_WIRE_21),
	.equal(SYNTHESIZED_WIRE_19),
	.above(SYNTHESIZED_WIRE_20),
	.errorFlag(SYNTHESIZED_WIRE_22),
	.result(SYNTHESIZED_WIRE_23));
	defparam	b2v_inst11.DWIDTH = 32;
	defparam	b2v_inst11.FWIDTH = 2;


execute	b2v_inst14(
	.clk(clk),
	.rst(SYNTHESIZED_WIRE_51),
	.full_stack(SYNTHESIZED_WIRE_17),
	.empty_stack(SYNTHESIZED_WIRE_18),
	.equal(SYNTHESIZED_WIRE_19),
	.above(SYNTHESIZED_WIRE_20),
	.below(SYNTHESIZED_WIRE_21),
	.error(SYNTHESIZED_WIRE_22),
	.data(SYNTHESIZED_WIRE_23),
	.instr(SYNTHESIZED_WIRE_53),
	.mux_register(SYNTHESIZED_WIRE_25),
	.register(SYNTHESIZED_WIRE_56),
	.reset_regs(SYNTHESIZED_WIRE_57),
	.r_abs(SYNTHESIZED_WIRE_50),
	.RFlags(RFlags),
	.stored_data(SYNTHESIZED_WIRE_59),
	.stored_instr(SYNTHESIZED_WIRE_60),
	.stored_register(SYNTHESIZED_WIRE_45));
	defparam	b2v_inst14.DWIDTH = 32;


branch_controller	b2v_inst15(
	.clk(clk),
	.rst(SYNTHESIZED_WIRE_51),
	.branch_addr(SYNTHESIZED_WIRE_28),
	.immediate(SYNTHESIZED_WIRE_54),
	.instr(SYNTHESIZED_WIRE_53),
	.rd(SYNTHESIZED_WIRE_55),
	.full(SYNTHESIZED_WIRE_17),
	.empty(SYNTHESIZED_WIRE_18),
	.r_abs(SYNTHESIZED_WIRE_25));
	defparam	b2v_inst15.AWIDTH = 15;
	defparam	b2v_inst15.DWIDTH = 32;

assign	SYNTHESIZED_WIRE_51 = rst | SYNTHESIZED_WIRE_57;


registers	b2v_inst21(
	.enable_write(SYNTHESIZED_WIRE_33),
	.enable_read(SYNTHESIZED_WIRE_34),
	.addr1(SYNTHESIZED_WIRE_35),
	.addr2(SYNTHESIZED_WIRE_36),
	.data(SYNTHESIZED_WIRE_37),
	.instr(SYNTHESIZED_WIRE_58),
	.data_out1(SYNTHESIZED_WIRE_4),
	.data_out2(SYNTHESIZED_WIRE_5));


muxbank	b2v_inst23(
	.fetch_instr(SYNTHESIZED_WIRE_52),
	.read_en(SYNTHESIZED_WIRE_34),
	.addr_1(SYNTHESIZED_WIRE_35),
	.addr_2(SYNTHESIZED_WIRE_36));
	defparam	b2v_inst23.DWIDTH = 32;
	defparam	b2v_inst23.MWIDTH = 5;


write_back	b2v_inst24(
	.data_input(SYNTHESIZED_WIRE_40),
	.instruction(SYNTHESIZED_WIRE_58),
	.mem_data_input(SYNTHESIZED_WIRE_42),
	.write_en(SYNTHESIZED_WIRE_33),
	.output_data(SYNTHESIZED_WIRE_37));


memory_access_mux	b2v_inst3(
	.data_ula(SYNTHESIZED_WIRE_59),
	.instr(SYNTHESIZED_WIRE_60),
	.register_data(SYNTHESIZED_WIRE_45),
	.read_enable(read_enable),
	.write_enable(write_enable),
	.addr(addr),
	.data_out(SYNTHESIZED_WIRE_48));
	defparam	b2v_inst3.AWIDTH = 15;
	defparam	b2v_inst3.DWIDTH = 32;


store	b2v_inst6(
	.clk(clk),
	.rst(rst),
	.data(SYNTHESIZED_WIRE_59),
	.instr(SYNTHESIZED_WIRE_60),
	.mem_data(SYNTHESIZED_WIRE_48),
	.stored_data(SYNTHESIZED_WIRE_40),
	.stored_instr(SYNTHESIZED_WIRE_58),
	.stored_mem_data(SYNTHESIZED_WIRE_42));
	defparam	b2v_inst6.DWIDTH = 32;


pc	b2v_inst7(
	.clk(clk),
	.rst(rst),
	.sel(SYNTHESIZED_WIRE_57),
	.instr(SYNTHESIZED_WIRE_50),
	.out(SYNTHESIZED_WIRE_8));
	defparam	b2v_inst7.ADDR_SIZE = 15;
	defparam	b2v_inst7.OPT_SIZE = 1;
	defparam	b2v_inst7.WORD_SIZE = 32;


endmodule
