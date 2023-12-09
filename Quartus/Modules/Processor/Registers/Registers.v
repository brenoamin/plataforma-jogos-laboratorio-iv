module Registers (
	input wire [31:0] data,
	input wire [31:0] instruction,
	input wire [4:0] address1,
	input wire [4:0] address2,
	input wire enable_write,
	input wire enable_read,
	output reg [31:0] data_out1,
	output reg data_out2
);

	reg[31:0] registers[31:0];

	localparam LW = 0;
	localparam SW = 1;
	localparam MOV = 2;

	localparam ADD = 3;
	localparam SUB = 4;
	localparam MUL = 5;
	localparam DIV = 6;

	localparam AND = 7;
	localparam OR = 8;
	localparam SHL = 9;
	localparam SHR = 10;
	localparam CMP = 11;
	localparam NOT = 12;

	always @(*) begin
		if (enable_write) begin
			case(instruction[31:27])
			  LW: begin
				 registers[instruction[26:22]] = data;
			  end
			  
			  MOV: begin
				 registers[instruction[26:22]] = registers[instruction[4:0]];
			  end
			  
			  ADD, SUB, MUL, DIV, AND, OR, SHL, SHR, NOT: begin
				 registers[instruction[26:22]] = data;
			  end
			  
			  default: begin
			  end
			endcase
		end
		else if (enable_read) begin
			data_out1 = registers[address1];
			data_out2 = registers[address2];
		end
	end
endmodule