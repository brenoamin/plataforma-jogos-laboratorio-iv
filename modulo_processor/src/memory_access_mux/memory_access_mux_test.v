`include "memory_access_mux.v"

module memory_access_mux_tb;

  localparam integer AWIDTH = 15;
  localparam integer DWIDTH = 32;

  //Ports
  reg  [DWIDTH-1:0] instr;
  reg  [DWIDTH-1:0] data_ula;
  reg  [DWIDTH-1:0] register_data;
  wire [DWIDTH-1:0] data_out;
  wire [AWIDTH-1:0] addr;
  wire  read_enable;
  wire  write_enable;

  memory_access_mux # (
    .AWIDTH(AWIDTH),
    .DWIDTH(DWIDTH)
  )
  memory_access_mux_inst (
    .instr(instr),
    .data_ula(data_ula),
    .register_data(register_data),
    .data_out(data_out),
    .addr(addr),
    .read_enable(read_enable),
    .write_enable(write_enable)
  );

  task expect;
    input [AWIDTH-1:0] exp_addr;
    input [DWIDTH-1:0] exp_data;
    input exp_read_enable;
    input exp_write_enable;

    if ((addr != exp_addr) || (data_out !== exp_data) || (read_enable !== exp_read_enable) || (write_enable !== exp_write_enable))
    begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data_out=%b read_enable=%b write_enable=%b", $time, addr, data_out, read_enable, write_enable);
      $display("Expected values: addr=%b data_out=%b read_enable=%b write_enable=%b", exp_addr, exp_data, exp_read_enable, exp_write_enable);
      $finish;
    end
    else
    begin
      $display("At time %0d addr=%b data_out=%b read_enable=%b write_enable=%b", $time, addr, data_out, read_enable, write_enable);
    end
endtask


  initial begin
    // Dump variables to VCD file
    $dumpfile("memory_access_mux.vcd");
    $dumpvars(0, memory_access_mux_tb);
  end

  initial begin
    $display("LW Instruction: ");
    instr = 32'b0;
    data_ula = 32'b0;
    #2;

    $display("instr = %b", instr);
    expect(32'b0, {DWIDTH{1'bz}}, 1, 0);


    $display("SW Instruction: ");
    instr = {4'b0, 1'b1, 27'b0};
    data_ula = 32'b0;
    register_data = 32'b1;
    #2;

    $display("instr = %b", instr);
    expect(32'b0, 32'b1, 0, 1);

    $display("Default Instruction: ");
    #2
    instr = {4'b0011, 1'b1, 27'b0};
    data_ula = 32'b0;
    #2;
    $display("instr = %b", instr);
    expect({AWIDTH{1'bz}},32'b0,0,0);

    $display("TEST PASSED");
    $finish;
  end
endmodule