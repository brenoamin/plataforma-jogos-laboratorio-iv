`include "src/extensor/extensor.v"
`timescale 1ns/1ps

module extensor_test;

  // Parameters
  // Ports
  reg [31:0] instruction;
  wire [31:0] immediate;

  extensor extensor_inst (
             .instruction(instruction),
             .immediate(immediate)
           );

  task expect(input [31:0] exp_out);
    begin
      if (immediate !== exp_out)
      begin
        $display("TEST FAILED");
        $display("At time %0t instruction=%b immediate=%b expected=%b", $time, instruction, immediate, exp_out);
        $finish;
      end
      else
      begin
        $display("At time %0t instruction=%b immediate=%b expected=%b", $time, instruction, immediate, exp_out);
      end
    end
  endtask

  initial
  begin
    $dumpfile("extensor_test.vcd");
    $dumpvars(0, extensor_test);

    //DATA_TRANSFER

    $display("DATA_TRANSFER: ");

    // Test case 1: Positive immediate
    #2;
    instruction = 32'b0000_0000_0000_0000_1010_1010_1010_1010;
    #1;
    expect(32'b0000_0000_0000_0000_0000_0010_1010_1010);

    // Test case 2: Negative immediate
    #2;
    instruction = 32'b0000_0000_0010_0000_1111_1111_1111_1111;
    #1;
    expect(32'b1111_1111_1111_1111_1000_0011_1111_1111);

    // ARITHMETIC_AND_LOGICAL

    $display("ARITHMETIC_AND_LOGICAL: ");

    // Test case 1: Positive immediate
    #2;
    instruction = 32'b0001_1000_0000_0000_1010_0010_1010_1010;
    #1;
    expect(32'b0000_0000_0000_0000_0000_0010_1010_1010);

    // Test case 2: Negative immediate
    #2;
    instruction = 32'b0001_1000_0000_0000_1010_1010_1010_1010;
    #1;
    expect(32'b1111_1111_1111_1111_1111_1010_1010_1010);


    // CONTROL_TRANSFER

    $display("CONTROL_TRANSFER: ");

    // Test case 1: Positive immediate
    #2;
    instruction = 32'b0111_0000_0000_0000_0001_0000_0000_0000;
    #1;
    expect(32'b0000_0000_0000_0000_0001_0000_0000_0000);

    // Test case 2: Negative immediate
    #2;
    instruction = 32'b0111_0100_0000_0000_0001_0000_0000_0000;
    #1;
    expect(32'b1111_1100_0000_0000_0001_0000_0000_0000);


    // DEFAULT

    $display("DEFAULT: ");

    #2;
    instruction = 32'b1111_1000_0000_0000_0001_0000_0000_0000;
    #1;
    expect(32'b0000_0000_0000_0000_0000_0000_0100_0000);


    $display("TESTS PASSED SUCCESSFULLY!");
    $finish;
  end

endmodule
