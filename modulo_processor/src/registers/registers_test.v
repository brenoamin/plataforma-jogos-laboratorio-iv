`include "src/registers/registers.v"
`timescale 1ns/1ps

module registers_test;
  reg [31:0] data, instr;
  reg [4:0] addr1, addr2, aux;
  reg enable_write, enable_read;
  wire [31:0] data_out1, data_out2;
  integer i;


  registers u1 (
              .data(data),
              .instr(instr),
              .addr1(addr1),
              .addr2(addr2),
              .enable_write(enable_write),
              .enable_read(enable_read),
              .data_out1(data_out1),
              .data_out2(data_out2)
            );

  initial
  begin
    data = 0;
    instr = 0;
    addr1 = 0;
    addr2 = 0;
    enable_write = 1;
    enable_read = 0;

    for (i=0; i<31; ++i)
    begin
      aux = i;
      instr = {5'b0, aux, 22'b0};
      #1;
    end

    enable_write = 1;
    instr = 32'b00000000000000000000000000000000;
    data = 32'b00000000000000000000000000000111;
    #1;

    enable_write = 0;
    enable_read = 1;
    addr1 = 0;
    #1;

    if (data_out1 == data)
    begin
      $display("LW Test passed");
    end
    else
    begin
      $display("LW Test failed");
    end

    enable_write = 1;
    instr = 32'b00010000110000000000000000000101;
    #1;

    enable_write = 0;
    enable_read = 1;
    addr1 = 5'b00101;
    addr2 = 5'b00011;
    #1;

    if (data_out1 == data_out2)
    begin
      $display("MOV Test passed");
    end
    else
    begin
      $display("MOV Test failed: %d != %d", data_out1, data_out2);
    end

    enable_write = 1;
    instr = 32'b00011000000000000000000000000000;
    data = 32'b00011000000000000000000000001010;
    #1;

    enable_write = 0;
    enable_read = 1;
    addr1 = 5'b00000;
    #1;

    if (data_out1 == data)
    begin
      $display("ADD Test passed");
    end
    else
    begin
      $display("ADD Test failed");
    end

    $finish;
  end
endmodule
