`include "src/cpu.v"
`timescale 1ns/1ps

module cpu_test;

  reg clk, rst;
  reg [MEMORY_AWIDTH-1:0] pc_instr = 0;

  localparam integer PC_AWIDTH = 20;
  localparam integer MEMORY_AWIDTH = 15;
  localparam integer DWIDTH = 32;
  localparam integer PC_OPT_SIZE = 2;

  localparam PROGRAM_FILE = "../src/program.txt";

  cpu #(.PROGRAM_FILE(PROGRAM_FILE)) cpu_dut(.clk(clk), .pc_instr(pc_instr), .pc_rst(rst));

  initial
  begin

    $dumpfile("cpu.vcd");
    $dumpvars(0, cpu_test);

    repeat(50)
    begin
      clk = 0;
      #1;
      clk = 1;
      #1;
    end

    $display("TIMEOUT");
    $finish;
  end

  initial
  begin

    // Reset CPU
    @(negedge(clk));
    rst = 1;
    @(negedge(clk));
    rst = 0;

    $display("TESTS PASSED");
  end

endmodule
