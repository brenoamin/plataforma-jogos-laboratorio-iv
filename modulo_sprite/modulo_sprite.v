// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Sun Dec 10 22:11:46 2023"

module modulo_sprite(
	v_sync,
	h_sync,
	CLOCK_50,
	rst,
	active_function_processor,
	function_col,
	function_id_sprit,
	function_input01,
	function_input02,
	function_level_sprit,
	function_row,
	function_selector,
	function_sp_colision_out,
	active_high_four,
	anchor_x_out,
	anchor_y_out,
	high_four_out,
	layer_out
);


input wire	v_sync;
input wire	h_sync;
input wire	CLOCK_50;
input wire	rst;
input wire	active_function_processor;
input wire	[9:0] function_col;
input wire	[5:0] function_id_sprit;
input wire	[5:0] function_input01;
input wire	[5:0] function_input02;
input wire	[5:0] function_level_sprit;
input wire	[9:0] function_row;
input wire	[1:0] function_selector;
output wire	function_sp_colision_out;
output wire	active_high_four;
output wire	[9:0] anchor_x_out;
output wire	[9:0] anchor_y_out;
output wire	[5:0] high_four_out;
output wire	[5:0] layer_out;

wire	SYNTHESIZED_WIRE_0;
wire	[9:0] SYNTHESIZED_WIRE_1;
wire	[9:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;





sprits_finder_position	b2v_inst(
	.clk(CLOCK_50),
	.rst(rst),
	.active_finder_position(SYNTHESIZED_WIRE_0),
	.active_function_processor(active_function_processor),
	.function_col(function_col),
	.function_id_sprit(function_id_sprit),
	.function_input01(function_input01),
	.function_input02(function_input02),
	.function_level_sprit(function_level_sprit),
	.function_row(function_row),
	.function_selector(function_selector),
	.H_pos_in(SYNTHESIZED_WIRE_1),
	.V_pos_in(SYNTHESIZED_WIRE_2),
	.function_sp_colision_out(function_sp_colision_out),
	.active_high_four(active_high_four),
	.anchor_x_out(anchor_x_out),
	.anchor_y_out(anchor_y_out),
	.high_four_out(high_four_out),
	.layer_out(layer_out));
	defparam	b2v_inst.function_sprite_colision = 2'b00;
	defparam	b2v_inst.function_sprite_level = 2'b00;
	defparam	b2v_inst.function_sprite_pos = 2'b00;
	defparam	b2v_inst.no_sprite_id = 6'b111111;
	defparam	b2v_inst.state_comparacao_perimetro = 2'b01;
	defparam	b2v_inst.state_controller_memory = 2'b11;
	defparam	b2v_inst.state_controller_memory00 = 4'b1011;
	defparam	b2v_inst.state_controller_memory01 = 4'b1100;
	defparam	b2v_inst.state_controller_memory02 = 4'b1101;
	defparam	b2v_inst.state_controller_memory03 = 4'b1110;
	defparam	b2v_inst.state_funcition_sp_level = 4'b0101;
	defparam	b2v_inst.state_function_sp_colision = 4'b0111;
	defparam	b2v_inst.state_function_sp_colision_out = 4'b1000;
	defparam	b2v_inst.state_function_sp_pos = 4'b0110;
	defparam	b2v_inst.state_inicio = 2'b00;
	defparam	b2v_inst.state_layers_prioritaria = 2'b10;
	defparam	b2v_inst.state_reset = 4'b1001;
	defparam	b2v_inst.state_selector_function = 4'b0100;


count_px_clk	b2v_inst1(
	.clk(CLOCK_50),
	.rst(rst),
	.pixel_clk(SYNTHESIZED_WIRE_3),
	.h_sync(h_sync),
	.active_finder_position(SYNTHESIZED_WIRE_0),
	.h_pos_out(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst1.state_counting_640 = 2'b10;
	defparam	b2v_inst1.state_counting_pixel = 2'b01;
	defparam	b2v_inst1.state_idle = 2'b00;
	defparam	b2v_inst1.state_reset = 2'b11;


count_h_sync	b2v_inst2(
	.clk(CLOCK_50),
	.rst(rst),
	.h_sync(h_sync),
	.v_sync(v_sync),
	.V_pos_out(SYNTHESIZED_WIRE_2));


PLL_pxc	b2v_inst3(
	.inclk0(CLOCK_50),
	.c0(SYNTHESIZED_WIRE_3));


endmodule
