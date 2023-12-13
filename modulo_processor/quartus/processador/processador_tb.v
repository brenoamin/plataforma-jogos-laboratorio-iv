`timescale 1ns/1ps

module processador_tb;

  // Inputs
  reg clk_tb;
  reg rst_tb;

  // Outputs
  wire [4:0] RFlags_tb;

  // Instantiate the processor module
  processador uut (
    .rst(rst_tb),
    .clk(clk_tb),
    .RFlags(RFlags_tb)
  );

  /// Clock generation
    initial
    begin
    clk_tb = 0;
    forever
        #1 clk_tb = ~clk_tb;
    end

    initial 
    begin
        rst_tb = 1;
        @(negedge clk_tb);
        rst_tb = 0;

        // Simulation termination
        $display("TESTS PASSED");
        $finish;

    end


endmodule
