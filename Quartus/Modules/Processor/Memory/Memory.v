module Memory #(
	parameter integer ADDRESS_WIDTH = 15,
	parameter integer DATA_WIDTH = 32,
	parameter INITIAL_MEMORY_DATA_PATH = ""
)(
	input wire [ADDRESS_WIDTH:0] address,
	input wire write,
	input wire read,
	input wire [DATA_WIDTH:0] in,
	output wire [DATA_WIDTH:0] out
);

	reg [DATA_WIDTH:0] memory [0:2**ADDRESS_WIDTH-1];
	reg [DATA_WIDTH:0] read_data;

	assign out = read ? read_data : {31{1'bz}};
	

	always @ (write, read, address) begin : MEMORY_ACCESS
		if (write)
			memory[address] = in;
		else if (read)
			read_data = memory[address];
	end
		
	initial begin
		if (INITIAL_MEMORY_DATA_PATH)
		begin
			$display("Creating initial memory from file '%s'.", INITIAL_MEMORY_DATA_PATH);
			$readmemb(INITIAL_MEMORY_DATA_PATH, memory);
		end
	end
endmodule