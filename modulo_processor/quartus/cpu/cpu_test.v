`timescale 1ns / 1ps

module cpu_tb;

    // Declare the signals that will connect to the cpu inputs and outputs
    reg clk;
    reg rst;
    reg [31:0] fetch_instr;
    wire read_enable;
    wire write_enable;
    wire [14:0] addr;
    wire [14:0] addr_mem;
    wire [31:0] data_out;
    wire [4:0] RFlags;

    // Instantiate the cpu
    cpu u_cpu (
        .clk(clk),
        .rst(rst),
        .fetch_instr(fetch_instr),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .addr(addr),
        .addr_mem(addr_mem),
        .data_out(data_out),
        .RFlags(RFlags)
    );

    initial begin
        // Initialize the signals
        clk = 0;
        rst = 1;
        fetch_instr = 32'b0;

        // Apply the reset
        #10 rst = 0;
        #10 rst = 1;

        // Add your test code here...
        // For example, you can apply some instructions to fetch_instr and check the outputs

    end

    // Generate a clock with a period of 20ns
    always #10 clk = ~clk;

endmodule