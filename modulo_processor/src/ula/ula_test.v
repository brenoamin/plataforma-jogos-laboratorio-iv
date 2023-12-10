`timescale 1ns/1ns

module ula_tb;

    // Inputs
    reg [31:0] operand_a;
    reg [31:0] operand_b;
    reg [31:0] inst;

    // Outputs
    wire [31:0] result;
  	wire equal, above, below, overflow, error;

    // Instantiate the ULA module
    ula uut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .inst(inst),
        .result(result),
        .equal(equal),
        .above(above),
        .below(below),
        .overflow(overflow),
        .error(error)
    );

    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;


  initial begin
      // Teste 01: ADD
        operand_a = 5; 
        operand_b = 8; 
        inst = 32'b00011111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;

          $display("TEST 01: ADD");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10

      // Teste 02: ADD - OVERFLOW
        operand_a = 32'b11111111111111111111111111111111;
        operand_b = 1;
        inst = 32'b00011111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
            $display("TEST 01: ADD");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10
      
      // Teste 03: SUB
        operand_a = 10;
        operand_b = 3;
        inst = 32'b00100111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
          $display("TEST 03: SUB");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10
      
      // Teste 04: SUB - OVERFLOW
        operand_a = 1;
        operand_b = 32'b11111111111111111111111111111111;
        inst = 32'b00100111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
          $display("TEST 04: SUB OVERFLOW");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10      

      // Teste 05: MULT - 
        operand_a = 2;
        operand_b = 8;
        inst = 32'b00101111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
          $display("TEST 05: SUB OVERFLOW");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10  
      
      // Teste 06: MULT - OVERFLOW
        operand_a = 2;
        operand_b = 32'b11111111111111111111111111111111;
        inst = 32'b00101111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
          $display("TEST 06: MUL OVERFLOW");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10  

      // Teste 07: DIV
        operand_a = 28;
        operand_b = 4;
        inst = 32'b00110111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
          $display("TEST 07: DIV OVERFLOW");
	        $display("inst: %d", inst[31:27]);
          	$display("Operand_A: %d", operand_a);
          	$display("Operand_B: %d", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10 
      
      // Teste 08: DIV - OVERFLOW
        operand_a = 32'b10000000000000000000000000000000;
        operand_b = 32'b11111111111111111111111111111111;
        inst = 32'b00110111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
            $display("TEST 08: DIV OVERFLOW");
	        $display("inst: %d", inst[31:27]);
          $display("Operand_A: %b", operand_a);
          $display("Operand_B: %b", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10   
      
      // Teste 09: AND
        operand_a = 1;
        operand_b = 1;
        inst = 32'b0111111001110001010000000000000;

        repeat (1) begin
            #10 operand_a = operand_a;
            #10 operand_b = operand_b;
            #10 inst = inst;
          $display("TEST 09: AND");
	        $display("inst: %d", inst[31:27]);
          $display("Operand_A: %b", operand_a);
          $display("Operand_B: %b", operand_b);
          	$display("Result: %d", result);
          $display("Overflow: %b\n", overflow);
        end
		#10        
      
        $finish;
    end

endmodule
