`timescale 1ns/1ps

module Alu_test;

	reg [3:0] operation;
	reg [31:0] operand_a;
	reg [31:0] operand_b;
	wire [31:0] result;
	wire [1:0] error_flag;
	 
	Alu Alu_instance(
		.operation(operation),
		.operand_a(operand_a),
		.operand_b(operand_b),
		.result(),
		.error_flag()
	);
	 
	initial begin
		// ADD
		operand_a = 10;
		operand_b = 5;
		operation = 4'b0011;
		#100 $display("ADD: %d + %d = %d, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		// SUB
		operand_a = 20;
		operand_b = 8;
		operation = 4'b0100;
		#100 $display("SUB: %d - %d = %d, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		// MUL
		operand_a = 15;
		operand_b = 5;
		operation = 4'b0010; 
		#100 $display("MUL: %d * %d = %d, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		// DIV
		operand_a = 40;
		operand_b = 4;
		operation = 4'b0110;
		#100 $display("DIV: %d / %d = %d, error_flag = %d", operand_a, operand_b, result, error_flag);

		// DIV
		operand_a = 10;
		operand_b = 0;
		operation = 4'b0110; 
		#100 $display("DIV: %d / %d = %d, error_flag = %d", operand_a, operand_b, result, error_flag);

		// AND
		operand_a = 5;
		operand_b = 3;
		operation = 4'b0111; 
		#100 $display("AND: %b & %b = %b, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		// OR
		operand_a = 5;
		operand_b = 3;
		operation = 4'b1000;
		#100 $display("OR: %b | %b = %b, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		// NOT
		operand_a = 1;
		operand_b = 0;
		operation = 4'b0110;
		#100 $display("NOT: ~%b = %b, error_flag = %d", operand_a, result, error_flag);
		
		// SHL
		operand_a = 8'b00111100;
		operand_b = 2;
		operation = 4'b0111;
		#100 $display("SHL: %b << %d = %b, error_flag = %d", operand_a, operand_b, result, error_flag);

		// SHR
		operand_a = 8'b00111100;
		operand_b = 1;
		operation = 4'b1000;
		#100 $display("SHR: %b >> %d = %b, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		// CMP
		operand_a = 10;
		operand_b = 20;
		operation = 4'b1001; // CMP
		#100 $display("CMP: %d, %d - result: %d, error_flag = %d", operand_a, operand_b, result, error_flag);
		
		#100 $finish;

	end
endmodule