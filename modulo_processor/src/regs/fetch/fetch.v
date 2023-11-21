module fetch #(
    parameter AWIDTH = 15,
    parameter DWIDTH = 32
  ) (
    input wire clk, rst,
    input wire [AWIDTH-1:0] fetch_addr,
    input wire [DWIDTH-1:0] fetch_instr,
    output reg [AWIDTH-1:0] fetched_addr,
    output reg [DWIDTH-1:0] fetched_instr
  );

  always @(posedge clk, posedge rst)
  begin : FETCH
    if (rst)
    begin
      fetched_addr <= 0;
      fetched_instr <= 0;
    end
    else
    begin
      fetched_addr <= fetch_addr;
      fetched_instr <= fetch_instr;
    end
  end
endmodule
