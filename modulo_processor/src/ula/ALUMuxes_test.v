`timescale 1ns/1ps

module ALUMuxes_test;

    // Parameters
    parameter integer DWIDTH = 32;

    // Inputs
    reg [DWIDTH-1:0] instr;
    reg [DWIDTH-1:0] immed;
    reg [4:0] Rd1;
    reg [4:0] Rd2;

    // Outputs
    wire [DWIDTH:0] operand_a;
    wire [DWIDTH:0] operand_b;

    // Instantiate the module
    ALUMuxes #(DWIDTH) uut (
        .instr(instr),
        .immed(immed),
        .Rd1(Rd1),
        .Rd2(Rd2),
        .operand_a(operand_a),
        .operand_b(operand_b)
    );

    // Simulation
    initial begin
        // Test case 1: Data Transfer operation (INST_LW)
        instr = 32'b00000111110000000000001010000011;
        immed = 32'h00001111;
        Rd1 = 5'b01111;
        Rd2 = 5'b00111;

        #10; 

        $display("Test Case 1:");
        $display("Input values:");      
        $display("instr = %b", instr);
		$display("immed = %b", immed);
		$display("Rd1 = %b", Rd1);
		$display("Rd2 = %b", Rd2);
      
        $display("Output values:");
        $display("operand_a = %b", operand_a);
        $display("operand_b = %b", operand_b);
        $display("------------------------------");

        #10;
        // Test case 2: Arithmetic operation (INST_ADD)
        instr = 32'b00011000110001111111000000000000;
        immed = 32'h11000000;
        Rd1 = 5'h0A;
        Rd2 = 5'h0B;

        #10;

        $display("Test Case 2:");
        $display("instr = %b", instr);
        $display("immed = %b", immed);
        $display("Rd1 = %b", Rd1);
        $display("Rd2 = %b", Rd2);

        $display("Output values:");
        $display("operand_a = %b", operand_a);
        $display("operand_b = %b", operand_b);
        $display("------------------------------");

        #10;
      
        $finish;
    end
endmodule