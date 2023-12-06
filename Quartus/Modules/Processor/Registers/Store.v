module Store #(
	parameter DATA_WIDTH = 32
)(
	input wire clock,
	input wire reset,
	input wire [DATA_WIDTH-1:0] data,
	input wire [DATA_WIDTH-1:0] memory_data,
	input wire [DATA_WIDTH-1:0] instruction,
	output reg [DATA_WIDTH-1:0] stored_data,
	output reg [DATA_WIDTH-1:0] stored_memory_data,
	output reg [DATA_WIDTH-1:0] stored_instruction
);

	always @(posedge clock, posedge reset) begin : STORE
		if (reset) begin
			stored_data <= 0;
			stored_memory_data <= 0;
			stored_instruction <= 0;
		end
		else begin
			stored_data <= data;
			stored_memory_data <= memory_data;
			stored_instruction <= instruction;
		end
	end
endmodule