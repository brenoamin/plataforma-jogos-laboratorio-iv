module WriteBack_test;

	localparam DATA_WIDTH = 32;

	reg [DATA_WIDTH-1:0] instruction;
	reg [DATA_WIDTH-1:0] in;
	reg [DATA_WIDTH-1:0] memory_in;
	wire [DATA_WIDTH-1:0] out;
	wire [DATA_WIDTH-1:0] immediate;

	integer i;
	
	WriteBack #(
		.DATA_WIDTH(DATA_WIDTH)
	) WriteBack_instance(
		.instruction(instruction),
		.in(in),
		.memory_in(memory_in),
		.out(out)
	);

  task expects(input [31:0] expected_out);
    begin
      if (out !== expected_out)
      begin
        $display("TEST FAILED");
        $display("At time %0t `instruction`=%b `out`=%b `expected_out`=%b", $time, instruction, out, expected_out);
        $finish;
      end
      else
      begin
        $display("At time %0t `instruction`=%b `out`=%b `expected_out`=%b", $time, instruction, out, expected_out);
      end
    end
  endtask


  initial
  begin
    $dumpfile("WriteBack_test.vcd");
    $dumpvars(0, WriteBack_test);

    //DATA_TYPE
    for (i = 2; i <= 18; i = i + 1)
    begin
      $display("DATA_TYPE INSTRUCTION = %d ", i);
      #2;
      instruction = {5'b0, i, instruction[26:0]};
      in = $random;
      memory_in = $random;
      #1;
      expects(in);
      #2;
    end


    //MEM_DATA_TYPE_LW

    $display("MEM_DATA_TYPE(LW): ");
    #2;
    in = 32'b1111_0010_0011_1000_1111_1010_1010_1010;
    memory_in = 32'b1000_1111_0011_1000_1111_1010_1010_1010;
    instruction = 32'b0000_0000_0000_0000_1010_1010_1010_1010;
    #1;
    expects(memory_in);

    //MEM_DATA_TYPE_SW


    $display("MEM_DATA_TYPE(SW): ");
    #2;
    in = 32'b1111_0010_0011_1000_1111_1010_1010_1010;
    memory_in = 32'b1000_1111_0011_1000_1111_1010_1010_1010;
    instruction = 32'b0000_1000_0000_0000_1010_1010_1010_1010;
    #1;
    expects(memory_in);

    //DEFAULT

    $display("DEFAULT: ");

    #2;
    in = 32'b1111_0010_0011_1000_1111_1010_1010_1010;
    memory_in = 32'b1000_1111_0011_1000_1111_1010_1010_1010;
    instruction = 32'b1111_1000_0000_0000_1010_1010_1010_1010;
    #1;
    expects(in);


    $display("TESTS PASSED SUCCESSFULLY!");
    $finish;
  end

endmodule