module Execute #(
	parameter DATA_WIDTH = 32
)(
	input wire clock,
	input wire reset
);

	always @(posedge clock, posedge reset) begin : EXECUTE
	end
endmodule