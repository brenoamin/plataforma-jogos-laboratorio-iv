module pc_test;

localparam WORD_SIZE = 32;
localparam ADDR_SIZE = 14;
localparam OPT_SIZE = 2;
localparam NEXT_INSTR = 0, KEEP_INSTR = 1, LOAD_INSTR = 2;

reg clk, rst;
reg [WORD_SIZE-1:0] instr;
reg [OPT_SIZE-1:0]  sel;
wire [WORD_SIZE-1:0] out;

reg [8*10:0] status; 

integer i;

pc 
#(
    .WORD_SIZE(WORD_SIZE), 
    .ADDR_SIZE(ADDR_SIZE)
 ) DUT (
    .clk(clk),
    .rst(rst),
    .instr(instr),
    .sel(sel),
    .out(out)
 );

task expect(input [WORD_SIZE-1:0] exp_out);
    begin
        status = "verify";
        if (out !== exp_out) begin
            $display("TEST FAILED");
            $display("At time %0d rst=%b sel=%b instr=%x out=%x",
                    $time, rst, sel, instr, out);
            $display("out should be %d", exp_out);
            $finish;
        end
        else begin
            $display("At time %0d rst=%b sel=%b instr=%x out=%x",
                    $time, rst, sel, instr, out);
        end
    end
endtask

task reset_pc;
begin
    @(negedge clk); rst = 1;
    status = "reset";
    @(negedge clk); rst = 0;
end
endtask

task wait_random;
    #($unsigned($random) % 10);
endtask

always #1 clk = ~clk;

initial begin
    $dumpfile("pc_test.vcd");
    $dumpvars(0, pc_test);

    status = "test init";
    clk = 0;

    // Test reset
    wait_random; 
    reset_pc; 
    @(posedge clk); expect(0);
    
    // Test pc = pc + 1;
    wait_random;
    sel = NEXT_INSTR;
    for(i=0; i<10; i=i+1) begin
        status = "next";
        @(posedge clk);
        expect(i);
        @(negedge clk);
    end

    // Test load instruction
    for(i=0; i<10; i=i+1) begin
        status = "load";
        @(negedge clk);
        instr = $random;
        sel = LOAD_INSTR;
        @(negedge clk);
        expect(instr);
        #($unsigned($random) % 10);
    end

    wait_random;
    status = "load";
    sel = LOAD_INSTR;
    instr = $random;
    @(posedge clk);
    wait_random;
    expect(instr);
    
    // Test keep
    wait_random;
    sel = KEEP_INSTR;
    reset_pc;
    @(posedge clk);
    wait_random;
    expect(0);

    wait_random; 
    $display("TEST PASSED"); $finish;
end
    
endmodule

// iverilog -t null *.v
// iverilog -o a.out pc_test.v  && vvp a.out
// gtkwave pc_test.vcd &