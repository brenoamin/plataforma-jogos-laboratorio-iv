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
// CREATED		"Wed Dec 13 12:44:49 2023"

module processor(
	rst,
	CLOCK_50,
	RFlags
);


input wire	rst;
input wire	CLOCK_50;
output wire	[4:0] RFlags;

wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	[14:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	[14:0] SYNTHESIZED_WIRE_8;





cpu	b2v_inst(
	.clk(CLOCK_50),
	.rst(rst),
	.fetch_instr(SYNTHESIZED_WIRE_0),
	.mem_data_in(SYNTHESIZED_WIRE_1),
	.read_enable(SYNTHESIZED_WIRE_11),
	.write_enable(SYNTHESIZED_WIRE_10),
	.addr(SYNTHESIZED_WIRE_8),
	.addr_mem(SYNTHESIZED_WIRE_4),
	.data_out(SYNTHESIZED_WIRE_12),
	.RFlags(RFlags));


mem_data	b2v_inst1(
	.wren(SYNTHESIZED_WIRE_10),
	.rden(SYNTHESIZED_WIRE_11),
	.clock(CLOCK_50),
	.address(SYNTHESIZED_WIRE_4),
	.data(SYNTHESIZED_WIRE_12),
	.q(SYNTHESIZED_WIRE_1));


mem_program	b2v_inst2(
	.wren(SYNTHESIZED_WIRE_10),
	.rden(SYNTHESIZED_WIRE_11),
	.clock(CLOCK_50),
	.address(SYNTHESIZED_WIRE_8),
	.data(SYNTHESIZED_WIRE_12),
	.q(SYNTHESIZED_WIRE_0));


endmodule
