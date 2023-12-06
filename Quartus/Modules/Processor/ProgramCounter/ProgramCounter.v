module ProgramCounter #(
	parameter WORD_SIZE = 15
)(
	input wire clock,
	input wire reset,
	input wire [1:0] selector,
	input wire [WORD_SIZE-1:0] instruction,
	output reg [WORD_SIZE-1:0] out
);

	localparam SELECTOR_NEXT_INSTRUCTION = 0;
	localparam SELECTOR_KEEP_INSTRUCTION = 1;
	localparam SELECTOR_LOAD_INSTRUCTION = 2;

	always @ (posedge clock) begin
		if (reset == 1'b1)
			out <= 0;
		else begin
			case (selector)
				SELECTOR_NEXT_INSTRUCTION:
					out <= out + 1;
				SELECTOR_KEEP_INSTRUCTION:
					out <= out;
				SELECTOR_LOAD_INSTRUCTION:
					out <= instruction;
			endcase
		end
	end
endmodule