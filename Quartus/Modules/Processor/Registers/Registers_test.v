`timescale 1ns/1ps

module registers_test;
	reg [31:0] data;
	reg [31:0] instruction;
	reg [4:0] address1;
	reg [4:0] address2;
	reg [4:0] aux;
	reg enable_write;
	reg enable_read;
	wire [31:0] data_out1;
	wire [31:0]data_out2;
	integer i;


	Registers Registers_inst (
		.data(data),
		.instruction(instruction),
		.address1(address1),
		.address2(address2),
		.enable_write(enable_write),
		.enable_read(enable_read),
		.data_out1(data_out1),
		.data_out2(data_out2)
	);

	initial begin
		data = 0;
		instruction = 0;
		address1 = 0;
		address2 = 0;
		enable_write = 1;
		enable_read = 0;

		for (i=0; i<31; i = i + 1) begin
			aux = i;
			instruction = {5'b0, aux, 22'b0};
			#1;
		end

		enable_write = 1;
		instruction = 32'b00000000000000000000000000000000;
		data = 32'b00000000000000000000000000000111;
		#1;

		enable_write = 0;
		enable_read = 1;
		address1 = 0;
		#1;

		if (data_out1 == data) begin
			$display("LW Test passed");
		end
		else begin
			$display("LW Test failed");
		end

		enable_write = 1;
		instruction = 32'b00010000110000000000000000000101;
		#1;

		enable_write = 0;
		enable_read = 1;
		address1 = 5'b00101;
		address2 = 5'b00011;
		#1;

		if (data_out1 == data_out2) begin
			$display("MOV Test passed");
		end
		else begin
			$display("MOV Test failed: %d != %d", data_out1, data_out2);
		end

		enable_write = 1;
		instruction = 32'b00011000000000000000000000000000;
		data = 32'b00011000000000000000000000001010;
		#1;

		enable_write = 0;
		enable_read = 1;
		address1 = 5'b00000;
		#1;

		if (data_out1 == data) begin
			$display("ADD Test passed");
		end
		else begin
		$display("ADD Test failed");
		end

		$finish;
  end
endmodule