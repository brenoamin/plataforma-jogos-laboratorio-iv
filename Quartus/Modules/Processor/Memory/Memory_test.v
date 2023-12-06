`timescale 1ns/1ps

module Memory_test;

	localparam integer MEMORY_ADDRESS_WIDTH = 15;
	localparam integer DATA_WIDTH = 32;

	reg write;
	reg read;
	reg [MEMORY_ADDRESS_WIDTH-1:0] address;
	reg [DATA_WIDTH-1:0] data;
	wire [DATA_WIDTH-1:0] out;
	reg [DATA_WIDTH-1:0] data_to_write[0:3];

	Memory #(
		.ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH),
		.DATA_WIDTH(DATA_WIDTH)
	) Memory_instance(
		.write(write),
		.read(read),
		.address(address),
		.out(out)
	);
  
	task expects(input [DATA_WIDTH-1:0] expected_out);
	 if (out !== expected_out)
	 begin
		$display("TEST FAILED");
		$display("At time %0d `address`=%b `out`=%b", $time, address, out);
		$display("`out` should be %b", expected_out);
		$finish;
	 end
	 else
	 begin
		$display("At time %0d `address`=%b `out`=%b", $time, address, out);
	 end
	endtask

	initial
	begin
		$dumpfile("Memory_test.vcd");
		$dumpvars(0, Memory_test);
	end


	initial
	begin
		$readmemb("instructions.txt", data_to_write);
	end

	initial
	begin : TEST
		// Writing 1
		$display("First writing: ");
		address = 0;
		data = -1;
		$display("Writing `address`=%b `data`=%b", address, data);
		write = 1;
		read = 0;
		#10;
		write = 0;
		#10;

		// Reading 1
		$display("First reading: ");

		address = 0;
		$display("Reading `address`=%b", address);
		write = 0;
		read = 1;
		#10;
		expects(data);

		// Writing 2
		$display("Second writing: ");

		address = 1;
		data = 42;
		$display("Writing `address`=%b data=%b", address, data);
		write = 1;
		read = 0;
		#10;
		write = 0;
		#10;

		// Reading 2
		$display("Second reading: ");

		address = 1;
		$display("Reading `address`=%b", address);
		write = 0;
		read = 1;
		#10;
		expects(data);

		// Writing 3
		$display("Third writing (file instruction.txt content): ");

		address = 2;
		data = data_to_write[0];
		$display("Writing `addres`s=%b data=%b", address, data);
		write = 1;
		read = 0;
		#10;
		write = 0;
		#10;

		// Reading 3
		$display("Third reading (file instruction.txt content): ");
		address = 2;
		$display("Reading `address`=%b", address);
		write = 0;
		read = 1;
		#10;
		expects(data);


		// Writing 4
		$display("Fourth writing (file instruction.txt content): ");

		address = 2;
		data = data_to_write[1];
		$display("Writing `addres`s=%b data=%b", address, data);
		write = 1;
		read = 0;
		#10;
		write = 0;
		#10;

		// Reading 4
		$display("Fourth reading (file instruction.txt content): ");
		address = 2;
		$display("Reading `address`=%b", address);
		write = 0;
		read = 1;
		#10;
		expects(data);


		// Writing 4
		$display("Fifth writing (file instruction.txt content): ");

		address = 2;
		data = data_to_write[2];
		$display("Writing `address`=%b data=%b", address, data);
		write = 1;
		read = 0;
		#10;
		write = 0;
		#10;

		// Reading 4
		$display("Fifth reading (file instruction.txt content): ");
		address = 2;
		$display("Reading `address`=%b", address);
		write = 0;
		read = 1;
		#10;
		expects(data);


		$display("TEST PASSED");
		$finish;
	end

endmodule