module GameEngine #(
	parameter PROGRAM_FILE_PATH = "",
	parameter DATA_WIDTH = 32
)(
	input wire clock,
	input wire reset
);

	reg [DATA_WIDTH-1:0] instruction;

	Processor #(
		.PROGRAM_FILE_PATH(PROGRAM_FILE_PATH),
		.DATA_WIDTH(DATA_WIDTH)
	) Processor_inst(
		.clock(clock),
		.reset(reset),
		.instruction(instruction)
	);

endmodule