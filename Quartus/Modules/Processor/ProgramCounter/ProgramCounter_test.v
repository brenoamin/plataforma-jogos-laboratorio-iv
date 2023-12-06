`timescale 1ns/1ps

module ProgramCounter_test;

	localparam WORD_SIZE = 15;
	localparam SELECTOR_NEXT_INSTRUCTION = 0;
	localparam SELECTOR_KEEP_INSTRUCTION = 1;
	localparam SELECTOR_LOAD_INSTRUCTION = 2;
	
	reg clock;
	reg reset;
	reg [1:0] selector;
	reg [WORD_SIZE-1:0] instruction;
	wire [WORD_SIZE-1:0] out;
	
	reg [8*10:0] status;
	integer i;
	
	ProgramCounter #(
		.WORD_SIZE(WORD_SIZE)
	) ProgramCounter_instance(
		.clock(clock),
		.reset(reset),
		.instruction(instruction),
		.selector(selector),
		.out(out)
	);
	
	task expects(input [WORD_SIZE-1:0] expected_out);
		begin
			status = "verify";
			if (out !== expected_out) begin
				$display("TEST FAILED");
            $display("At time %0d `reset`=%b `selector`=%b `instruction`=%x `out`=%x", $time, reset, selector, instruction, out);
            $display("Value of `out` should be %d", expected_out);
            $finish;
        end
        else begin
            $display("At time %0d `reset`=%b `selector`=%b `instruction`=%x `out`=%x", $time, reset, selector, instruction, out);
        end
		end
	endtask
	
	task reset_pc;
	begin
		 @(negedge clock); reset = 1;
		 status = "reset";
		 @(negedge clock); reset = 0;
	end
	endtask

	task wait_random;
		 #($unsigned($random) % 10);
	endtask

	always #1 clock = ~clock;

	initial begin
		 $dumpfile("ProgramCounter_test.vcd");
		 $dumpvars(0, pc_test);

		 status = "test init";
		 clock = 0;

		 // Test reset
		 wait_random; 
		 reset_pc; 
		 @(posedge clock); expects(0);
		 
		 // Test pc = pc + 1;
		 wait_random;
		 selector = SELECTOR_NEXT_INSTRUCTION;
		 for(i=0; i<10; i=i+1) begin
			  status = "next";
			  @(posedge clock);
			  expects(i);
			  @(negedge clock);
		 end

		 // Test load instruction
		 selector = SELECTOR_LOAD_INSTRUCTION;
		 for(i=0; i<10; i=i+1) begin
			  status = "load";
			  @(negedge clock);
			  instruction = $random;
			  @(negedge clock);
			  expects(instruction);
			  #($unsigned($random) % 10);
		 end
		 
		 // Test keep
		 wait_random;
		 selector = SELECTOR_KEEP_INSTRUCTION;
		 reset_pc;
		 @(posedge clock);
		 wait_random;
		 expects(0);

		 wait_random; 
		 $display("TEST PASSED"); $finish;
	end

endmodule