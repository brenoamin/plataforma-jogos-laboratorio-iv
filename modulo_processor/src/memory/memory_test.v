`include "memory.v"

module memory_test;

  localparam integer AWIDTH = 15;
  localparam integer DWIDTH = 32;

  reg wr;
  reg rd;
  reg [AWIDTH-1:0] addr;
  reg [DWIDTH-1:0] data;
  wire [DWIDTH-1:0] data_out;
  reg [DWIDTH-1:0] data_to_write[0:3];
  memory
    #(
      .AWIDTH (AWIDTH),
      .DWIDTH (DWIDTH)
    )
    memory_inst
    (
      .wr (wr),
      .rd (rd),
      .addr (addr),
      .data_in (data),
      .data_out (data_out)
    );

  task expect;
    input [DWIDTH-1:0] exp_data;
    if (data_out !== exp_data)
    begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data_out=%b", $time, addr, data_out);
      $display("data_out should be %b", exp_data);
      $finish;
    end
    else
    begin
      $display("At time %0d addr=%b data_out=%b", $time, addr, data_out);
    end
  endtask

  initial
  begin
    // Dump variables to VCD file
    $dumpfile("memory.vcd");
    $dumpvars(0, memory_test);
  end

  
  initial begin
    // Read data from instruction.txt for writing to memory
    $readmemb("instructions.txt", data_to_write);
  end

  initial
  begin : TEST

    // Writing 1
    $display("First writing: ");
    addr = 0;
    data = -1;
    $display("Writing addr=%b data=%b", addr, data);
    wr = 1;
    rd = 0;
    #10;
    wr = 0; 
    #10; 

    // Reading 1
    $display("First reading: ");

    addr = 0;
    $display("Reading addr=%b", addr);
    wr = 0;
    rd = 1;
    #10;
    expect(data);

    // Writing 2
    $display("Second writing: ");

    addr = 1;
    data = 42; 
    $display("Writing addr=%b data=%b", addr, data);
    wr = 1;
    rd = 0;
    #10; 
    wr = 0;
    #10;

    // Reading 2
    $display("Second reading: ");

    addr = 1;
    $display("Reading addr=%b", addr);
    wr = 0;
    rd = 1;
    #10;
    expect(data);

    // Writing 3
    $display("Third writing (file instruction.txt content): ");

    addr = 2;
    data = data_to_write[0];
    $display("Writing addr=%b data=%b", addr, data);
    wr = 1;
    rd = 0;
    #10;
    wr = 0; 
    #10; 

     // Reading 3
    $display("Third reading (file instruction.txt content): ");
    addr = 2;
    $display("Reading addr=%b", addr);
    wr = 0;
    rd = 1;
    #10;
    expect(data);


     // Writing 4
    $display("Fourth writing (file instruction.txt content): ");

    addr = 2;
    data = data_to_write[1];
    $display("Writing addr=%b data=%b", addr, data);
    wr = 1;
    rd = 0;
    #10;
    wr = 0; 
    #10; 

     // Reading 4
    $display("Fourth reading (file instruction.txt content): ");
    addr = 2;
    $display("Reading addr=%b", addr);
    wr = 0;
    rd = 1;
    #10;
    expect(data);


     // Writing 4
    $display("Fifth writing (file instruction.txt content): ");

    addr = 2;
    data = data_to_write[2];
    $display("Writing addr=%b data=%b", addr, data);
    wr = 1;
    rd = 0;
    #10;
    wr = 0; 
    #10; 

     // Reading 4
    $display("Fifth reading (file instruction.txt content): ");
    addr = 2;
    $display("Reading addr=%b", addr);
    wr = 0;
    rd = 1;
    #10;
    expect(data);

    
    $display("TEST PASSED");
    $finish;
  end

endmodule
