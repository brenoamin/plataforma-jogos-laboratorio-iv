module GameEngine #(
	parameter PROGRAM_FILE_PATH = "",
	parameter DATA_WIDTH = 32
)(
	input wire clock,
	input wire reset
);

	reg [DATA_WIDTH-1:0] instruction;

	wire [DATA_WIDTH-1:0] background_x;
	wire [DATA_WIDTH-1:0] background_y;
	wire [DATA_WIDTH-1:0] sprite_x;
	wire [DATA_WIDTH-1:0] sprite_y;
	wire [DATA_WIDTH-1:0] sprite_id;

	Processor #(
		.PROGRAM_FILE_PATH(PROGRAM_FILE_PATH),
		.DATA_WIDTH(DATA_WIDTH)
	) Processor_inst(
		.clock(clock),
		.reset(reset),
		.instruction(instruction),
		.background_x(background_x),
		.background_y(background_y),
		.sprite_x(sprite_x),
		.sprite_y(sprite_y),
		.sprite_id(sprite_id),
	);

	// Background #() Background_inst(
	//	.clock(clock),
	//	.reset(reset),
	//	.background_x(background_x),
	//	.background_y(background_y)
	//);

	// Sprite #() Sprite_inst(
	//	.clock(clock),
	//	.reset(reset),
	//	.sprite_x(sprite_x),
	//	.sprite_y(sprite_y),
	//	.sprite_id(sprite_id)
	//);

endmodule
