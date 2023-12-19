////UNIVERSIDADE FEDERAL DA BAHIA
////CÓDIGO REFERENTE A FINS AVALIATIVOS NA DISCIPLINA DE LABIV
////ALUNO: JOÃO RIOS

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
// CREATED		"Tue Dec 19 02:17:45 2023"

module SpriteMemoria(
	clock,
	rst,
	pixel,
	Saida_B,
	Saida_G,
	Saida_R
);


input wire	clock;
input wire	rst;
output wire	[23:0] pixel;
output wire	[7:0] Saida_B;
output wire	[7:0] Saida_G;
output wire	[7:0] Saida_R;

wire	SYNTHESIZED_WIRE_0;
wire	[9:0] SYNTHESIZED_WIRE_1;
wire	[3:0] SYNTHESIZED_WIRE_2;
wire	[3:0] SYNTHESIZED_WIRE_3;
wire	[4:0] SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_5;
wire	[12:0] SYNTHESIZED_WIRE_6;
wire	[17:0] SYNTHESIZED_WIRE_7;
wire	[23:0] SYNTHESIZED_WIRE_8;
wire	[4:0] SYNTHESIZED_WIRE_10;





comando	b2v_inst(
	.clock(clock),
	.rst(rst),
	.wren(SYNTHESIZED_WIRE_0),
	.addr(SYNTHESIZED_WIRE_1));


RAM3	b2v_inst1(
	.wren(SYNTHESIZED_WIRE_0),
	.clock(clock),
	.address(SYNTHESIZED_WIRE_1),
	
	.q(SYNTHESIZED_WIRE_7));


Processa_Sprite	b2v_inst2(
	.clock(clock),
	.reset(rst),
	.anchor_x(SYNTHESIZED_WIRE_2),
	.anchor_y(SYNTHESIZED_WIRE_3),
	.sprite_id(SYNTHESIZED_WIRE_11),
	.wren(SYNTHESIZED_WIRE_5),
	.addr(SYNTHESIZED_WIRE_6));


RAM2	b2v_inst3(
	.wren(SYNTHESIZED_WIRE_5),
	.clock(clock),
	
	.rdaddress(SYNTHESIZED_WIRE_6),
	
	.q(SYNTHESIZED_WIRE_8));


prepara_dados	b2v_inst5(
	.clock(clock),
	.rst(rst),
	.data_in(SYNTHESIZED_WIRE_7),
	.anchor_x(SYNTHESIZED_WIRE_2),
	.anchor_y(SYNTHESIZED_WIRE_3),
	.sprite_id(SYNTHESIZED_WIRE_11),
	.sprite_layer(SYNTHESIZED_WIRE_10));


merge_sprites	b2v_inst6(
	.clock(clock),
	.reset(rst),
	.data(SYNTHESIZED_WIRE_8),
	.sprite_id(SYNTHESIZED_WIRE_11),
	.sprite_layer(SYNTHESIZED_WIRE_10),
	.pixel(pixel),
	.Saida_B(Saida_B),
	.Saida_G(Saida_G),
	.Saida_R(Saida_R));


endmodule
