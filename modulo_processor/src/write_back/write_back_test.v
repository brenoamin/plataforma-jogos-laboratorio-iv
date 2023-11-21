`include "write_back.v"

module write_back_test;

  // Parameters
  // Ports
  reg [31:0] instruction;
  reg [31:0] data_input;
  reg [31:0] mem_data_input;
  wire [31:0] output_data;

  wire [31:0] immediate;

  integer i;

  write_back write_back_inst (
               .instruction(instruction),
               .data_input(data_input),
               .mem_data_input(mem_data_input),
               .output_data(output_data)
             );

  task expect(input [31:0] exp_out);
    begin
      if (output_data !== exp_out)
      begin
        $display("TEST FAILED");
        $display("At time %0t instruction=%b output_data=%b expected=%b", $time, instruction, output_data, exp_out);
        $finish;
      end
      else
      begin
        $display("At time %0t instruction=%b output_data=%b expected=%b", $time, instruction, output_data, exp_out);
      end
    end
  endtask



  initial
  begin
    $dumpfile("write_back_test.vcd");
    $dumpvars(0, write_back_test);

    //DATA_TYPE
    for (i = 2; i <= 18; i = i + 1)
    begin
      $display("DATA_TYPE INSTRUCTION = %d ", i);
      #2;
      instruction = {5'b0, i, instruction[26:0]};
      data_input = $random;
      mem_data_input = $random;
      #1;
      expect(data_input);
      #2;
    end


    //MEM_DATA_TYPE_LW

    $display("MEM_DATA_TYPE(LW): ");
    #2;
    data_input = 32'b1111_0010_0011_1000_1111_1010_1010_1010;
    mem_data_input = 32'b1000_1111_0011_1000_1111_1010_1010_1010;
    instruction = 32'b0000_0000_0000_0000_1010_1010_1010_1010;
    #1;
    expect(mem_data_input);

    //MEM_DATA_TYPE_SW


    $display("MEM_DATA_TYPE(SW): ");
    #2;
    data_input = 32'b1111_0010_0011_1000_1111_1010_1010_1010;
    mem_data_input = 32'b1000_1111_0011_1000_1111_1010_1010_1010;
    instruction = 32'b0000_1000_0000_0000_1010_1010_1010_1010;
    #1;
    expect(mem_data_input);

    //DEFAULT

    $display("DEFAULT: ");

    #2;
    data_input = 32'b1111_0010_0011_1000_1111_1010_1010_1010;
    mem_data_input = 32'b1000_1111_0011_1000_1111_1010_1010_1010;
    instruction = 32'b1111_1000_0000_0000_1010_1010_1010_1010;
    #1;
    expect(data_input);


    $display("TESTS PASSED SUCCESSFULLY!");
    $finish;
  end

endmodule
