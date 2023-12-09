module Alu (
	input wire [3:0] operation,
	input wire [31:0] operand_a,
	input wire [31:0] operand_b,
	output reg [31:0] result,
	output reg [1:0] error_flag
);

	// Available operations
	localparam ADD = 4'b0011;
	localparam SUB = 4'b0100;
	localparam MUL = 4'b0101;
	localparam DIV = 4'b0110;
	localparam AND = 4'b0111;
	localparam OR  = 4'b1000;
	localparam SHL = 4'b1001;
	localparam SHR = 4'b1010;
	localparam CMP = 4'b1011;
	localparam NOT = 4'b1100;

	always @ (*) begin
		case (operation)
			// Arithmetic
			ADD: result = operand_a + operand_b;
			SUB: result = operand_a - operand_b;
			MUL: result = operand_a * operand_b;
			DIV: begin
				result = (operand_b != 0) ? (operand_a / operand_b) : 32'b0;
				error_flag = (operand_b == 0) ? 2'b01 : 2'b00;
			end

			// Logical
			AND: result = operand_a & operand_b;
			OR: result = operand_a | operand_b;
			NOT: result = ~operand_a;
			SHL: result = operand_a << operand_b;
			SHR: result = operand_a >> operand_b;
			CMP: result = (operand_a == operand_b) ? 32'b00 : (operand_a > operand_b) ? 32'b01 : 32'b10;
			
			// Unknown Operation
			default: begin
				result = 32'b0;
				error_flag = 2'b10;
			end
		endcase
	end
endmodule
