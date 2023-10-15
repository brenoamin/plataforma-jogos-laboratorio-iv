module pc #(
    parameter WORD_SIZE = 32,
    parameter ADDR_SIZE = 14
) (
    input wire clk, rst,
    input wire [WORD_SIZE-1:0]  instr,
    input wire [OPT_SIZE-1:0]   sel,
    output reg [WORD_SIZE-1:0]  out
);

localparam OPT_SIZE = 2;
localparam NEXT_INSTR = 0, KEEP_INSTR = 1, LOAD_INSTR = 2;

always @(posedge clk) begin
    if (rst==1'b1) 
        out <= 0;
    else begin
        casez(sel)
            NEXT_INSTR: out <= out + 1;
            KEEP_INSTR: out <= out;
            LOAD_INSTR: out <= instr;
        endcase
    end
end

endmodule

// iverilog -t null *.v