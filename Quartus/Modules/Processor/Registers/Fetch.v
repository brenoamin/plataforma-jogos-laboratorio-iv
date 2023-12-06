module Fetch #(
	parameter ADDRESS_WIDTH = 15,
	parameter DATA_WIDTH = 32
)(
	input wire clock,
	input wire reset,
	input wire [ADDRESS_WIDTH-1:0] fetch_address,
	input wire [DATA_WIDTH-1:0] fetch_instruction,
	output reg [ADDRESS_WIDTH-1:0] fetched_address,
	output reg [DATA_WIDTH-1:0] fetched_instruction
);

	always @(posedge clock, posedge reset) begin : FETCH
		if (reset) begin
			fetched_address <= 0;
			fetched_instruction <= 0;
		end
		else begin
			fetched_address <= fetch_address;
			fetched_instruction <= fetch_instruction;
		end
	end
endmodule