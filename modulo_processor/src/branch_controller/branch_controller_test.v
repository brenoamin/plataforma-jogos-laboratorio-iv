`include "src/branch_controller/branch_controller.v"
`timescale 1ns/1ps

module branch_controller_tb;
  reg clk, rst;
  reg [14:0] addr;
  reg [31:0] immediate, rd, instr;
  wire [31:0] r_abs;
  wire full, empty;
  integer i;

  // Instantiate the module
  branch_controller u1 (
                      .clk(clk),
                      .rst(rst),
                      .addr(addr),
                      .immediate(immediate),
                      .rd(rd),
                      .instr(instr),
                      .r_abs(r_abs),
                      .full(full),
                      .empty(empty)
                    );

  initial
  begin
    // Initialize inputs
    clk = 0;
    rst = 1;
    addr = 0;
    immediate = 0;
    rd = 0;
    instr = 0;

    // Wait for 100 ns
    #10;

    // Deassert reset
    rst = 0;

    // Test JR operation
    instr = 32'b0110_1000_0000_0000_0000_0000_0000_0000; // JR instruction
    rd = 32'b0110_1000_0000_0000_0000_0000_0000_0000; // Some data
    #10;

    // Check the output
    if (r_abs == rd)
    begin
      $display("JR Test passed");
    end
    else
    begin
      $display("JR Test failed: r_abs = %d, expected = %d", r_abs, rd);
    end

    // Test JPC operation
    instr = 32'b0111_0000_0000_0000_0000_0000_0000_0000; // JPC instruction
    rd = 32'b0110_1000_0000_0000_0000_0000_0000_0000; // Some data
    immediate = 32'b0010_1000_0000_0000_0000_0000_0000_0000; // Some data
    #10;

    // Check the output
    if (r_abs == rd + immediate + 1)
    begin
      $display("JPC Test passed");
    end
    else
    begin
      $display("JPC Test failed: r_abs = %d, expected = %d", r_abs, rd + immediate + 1);
    end

    // Test CALL operation
    addr = 36;
    instr = 32'b1000_0000_0000_0000_0000_0000_0000_0000; // CALL instruction
    rd = 32'b0110_1000_0000_0000_0000_0000_0000_0000; // Some data
    #10;

    // Check the output
    if (r_abs == rd)
    begin
      $display("CALL Test passed");
    end
    else
    begin
      $display("CALL Test failed: r_abs = %d, expected = %d", r_abs, rd);
    end

    // Test RET operation
    instr = 32'b1000_1000_0000_0000_0000_0000_0000_0000; // RET instruction
    #10;

    // Check the output
    if (r_abs == addr)
    begin
      $display("RET Test passed");
    end
    else
    begin
      $display("RET Test failed: r_abs = %d, expected = %d", r_abs, addr);
    end


    rst = 1;
    #10;
    instr = 32'b1000_1000_0000_0000_0000_0000_0000_0000; // RET instruction
    rst = 0;
    #10

     // Test for empty stack
     if (empty == 1)
     begin
       $display("Empty Stack Test passed");
     end
     else
     begin
       $display("Empty Stack Test failed: empty = %d, expected = 1", empty);
     end

     // Fill the stack
     for (i = 0; i < 33; i = i + 1)
     begin
       instr = 32'b1000_0000_0000_0000_0000_0000_0000_0000; // CALL instruction
       rd = i; // Some data
       #10;
     end

     // Test for full stack
     if (full == 1)
     begin
       $display("Full Stack Test passed");
     end
     else
     begin
       $display("Full Stack Test failed: full = %d, expected = 1", full);
     end

     // End the simulation
     $finish;
  end

  // Clock generation
  always #5 clk = ~clk;

endmodule
