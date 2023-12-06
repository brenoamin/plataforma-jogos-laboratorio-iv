module Decode (
	input wire clock,
	input wire reset,
	input wire[31:0] instruction_set,
	output reg [4:0] instruction_code,
	output reg [4:0] R, Rd, Rs, Rb, M,
	output reg [31:0] immediate
);

	// Data Transfer Instructions
	localparam INSTRUCTION_LW = 5'b00000;
	localparam INSTRUCTION_SW = 5'b00001;
	localparam INSTRUCTION_MOV = 5'b00010;

	// Arithmetic Instructions
	localparam INSTRUCTION_ADD = 5'b00011;
	localparam INSTRUCTION_SUB = 5'b00100;
	localparam INSTRUCTION_MUL = 5'b00101;
	localparam INSTRUCTION_DIV = 5'b00110;

	// Logical Instructions
	localparam INSTRUCTION_AND = 5'b00111;
	localparam INSTRUCTION_OR = 5'b01000;
	localparam INSTRUCTION_SHL = 5'b01001;
	localparam INSTRUCTION_SHR = 5'b01010;
	localparam INSTRUCTION_CMP = 5'b01011;
	localparam INSTRUCTION_NOT = 5'b01100;

	// Control Transfer Instructions
	localparam INSTRUCTION_JR = 5'b01101;
	localparam INSTRUCTION_JPC = 5'b01110;
	localparam INSTRUCTION_BRFL = 5'b01111;
	localparam INSTRUCTION_CALL = 5'b10000;
	localparam INSTRUCTION_RET = 5'b10001;
	localparam INSTRUCTION_NOP = 5'b10010;

	always @(posedge clock, posedge reset) begin : DECODE
		if (reset) begin
			instruction_code <= 0;
			Rd <= 0;
			Rs <= 0;
			Rb <= 0;
			M <= 0;
			immediate <= 0;
		end else begin
			instruction_code <= instruction_set[31:27];
			case (instruction_code)
				INSTRUCTION_LW: begin
					Rd <= instruction_set[26:22];
					Rb <= instruction_set[4:0];
					immediate <= {instruction_set[21:6], 16'b0};
				end
				
				INSTRUCTION_SW: begin
					Rs <= instruction_set[26:22];
					Rb <= instruction_set[4:0];
					immediate <= {instruction_set[21:6], 16'b0};
				end
				
				INSTRUCTION_MOV: begin
					Rd <= instruction_set[26:22];
					Rs <= instruction_set[4:0];
				end
				
				INSTRUCTION_ADD, INSTRUCTION_SUB, INSTRUCTION_MUL, INSTRUCTION_DIV: begin
					Rd <= instruction_set[21:17];
					Rs <= instruction_set[16:12];
				end
				
				INSTRUCTION_AND, INSTRUCTION_OR, INSTRUCTION_SHL, INSTRUCTION_SHR, INSTRUCTION_CMP, INSTRUCTION_NOT: begin
					Rd <= instruction_set[21:17];
					Rs <= instruction_set[16:12];
				end
				
				INSTRUCTION_JR, INSTRUCTION_CALL: begin
					R <= instruction_set[14:10];
				end
				
				INSTRUCTION_BRFL: begin
					R <= instruction_set[14:10];
					M <= instruction_set[4:0];
					immediate <= instruction_set[9:5];
				end
				
				INSTRUCTION_JPC: begin
					immediate <= {instruction_set[13:7], 16'b0};
				end

				INSTRUCTION_RET, INSTRUCTION_NOP: begin
					// Does nothing
				end
			endcase
		end
	end
endmodule