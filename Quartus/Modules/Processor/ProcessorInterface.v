module ProcessorInterface #(
	parameter PROGRAM_FILE_PATH = ""
)(
	input wire clock,
	input wire reset,
	input wire [31:0] instruction,
	output wire [31:0] data_out
);
	Processor #(
		.PROGRAM_FILE_PATH(PROGRAM_FILE_PATH)
	) Processor_instance (
		.clock(clock),
		.reset(reset),
		.instruction(instruction)
	);

endmodule