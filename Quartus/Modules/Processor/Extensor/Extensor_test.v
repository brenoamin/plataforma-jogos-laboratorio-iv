`timescale 1ns/1ps

module Extensor_test;
	
	localparam DATA_WIDTH = 32;
	localparam INSTRUCTION_DATA_TRANSFER = 5'b00000;
	localparam INSTRUCTION_ARITHMETIC_AND_LOGICAL = 5'b00001;
	localparam INSTRUCTION_CONTROL_TRANSFER = 5'b00010;
	
	reg [DATA_WIDTH-1:0] instruction;
	wire [DATA_WIDTH-1:0] immediate;
	
	Extensor #(
		.DATA_WIDTH(DATA_WIDTH)
	) Extensor_instance(
		.instruction(instruction),
		.immediate(immediate)
	);
	
	task expects(input [31:0] expected_out);
		begin
			if (immediate !== expected_out)
				begin
					$display("TEST FAILED");
					$display("At time %0t `instruction`=%b `immediate`=%b `expected_out`=%b", $time, instruction, immediate, expected_out);
					$finish;
				end
			else
				begin
					$display("At time %0t `instruction`=%b `immediate`=%b `expected_out`=%b", $time, instruction, immediate, expected_out);
				end
		end
	endtask

	initial
		begin
			$dumpfile("Extensor_test.vcd");
			$dumpvars(0, Extensor_test);

			//DATA_TRANSFER

			$display("DATA_TRANSFER: ");

			// Test case 1: Positive immediate
			#2;
			instruction = 32'b0000_0000_0000_0000_1010_1010_1010_1010;
			#1;
			expects(32'b0000_0000_0000_0000_0000_0010_1010_1010);

			// Test case 2: Negative immediate
			#2;
			instruction = 32'b0000_0000_0010_0000_1111_1111_1111_1111;
			#1;
			expects(32'b1111_1111_1111_1111_1000_0011_1111_1111);

			// ARITHMETIC_AND_LOGICAL

			$display("ARITHMETIC_AND_LOGICAL: ");

			// Test case 1: Positive immediate
			#2;
			instruction = 32'b0000_1000_0000_0000_1010_0010_1010_1010;
			#1;
			expects(32'b0000_0000_0000_0000_0000_0010_1010_1010);

			// Test case 2: Negative immediate
			#2;
			instruction = 32'b0000_1000_0000_0000_1010_1010_1010_1010;
			#1;
			expects(32'b1111_1111_1111_1111_1111_1010_1010_1010);


			// CONTROL_TRANSFER

			$display("CONTROL_TRANSFER: ");

			// Test case 1: Positive immediate
			#2;
			instruction = 32'b0001_0000_0000_0000_0001_0000_0000_0000;
			#1;
			expects(32'b0000_0000_0000_0000_0001_0000_0000_0000);

			// Test case 2: Negative immediate
			#2;
			instruction = 32'b0001_0100_0000_0000_0001_0000_0000_0000;
			#1;
			expects(32'b1111_1100_0000_0000_0001_0000_0000_0000);


			// DEFAULT

			$display("DEFAULT: ");

			#2;
			instruction = 32'b0101_0000_0000_0000_0001_0000_0000_0000;
			#1;
			expects(32'b0101_0000_0000_0000_0001_0000_0000_0000);


			$display("TESTS PASSED SUCCESSFULLY!");
			$finish;
		end

endmodule