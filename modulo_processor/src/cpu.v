`include "src/pc/pc.v"
`include "src/memory/memory.v"
`include "src/regs/fetch/fetch.v"
`include "src/extensor/extensor.v"

module cpu #(
    parameter PROGRAM_FILE = ""
  )
  (
    input wire clk, pc_rst,
    input wire [MEMORY_AWIDTH-1:0] pc_instr
  );

  localparam integer PC_AWIDTH = 20;
  localparam integer MEMORY_AWIDTH = 15;
  localparam integer DWIDTH = 32;
  localparam integer PC_OPT_SIZE = 2;

  // Por enquanto
  reg [PC_OPT_SIZE-1:0] sel = 0;

  wire [MEMORY_AWIDTH-1:0] fetch_addr;

  pc
    #(
      .WORD_SIZE(MEMORY_AWIDTH),
      .ADDR_SIZE(PC_AWIDTH)
    )
    pc_inst
    (
      .clk(clk), .rst(pc_rst), .instr(pc_instr), .sel(sel),
      .out(fetch_addr)
    );

  wire [DWIDTH-1:0] fetch_instr;
  memory
    #(
      .AWIDTH (MEMORY_AWIDTH),
      .DWIDTH (DWIDTH),
      .INIT_MEMORY (PROGRAM_FILE)
    )
    memory_inst
    (
      .wr(1'b0),
      .rd (1'b1),
      .addr (fetch_addr),
      .data_out (fetch_instr)
    );

  wire [DWIDTH-1:0] fetched_instr;
  wire [MEMORY_AWIDTH-1:0] fetched_addr;

  fetch
    #(
      .AWIDTH(MEMORY_AWIDTH),
      .DWIDTH(DWIDTH)
    ) fetch_inst (
      .clk(clk),
      .rst(1'b0),
      .fetch_addr(fetch_addr),
      .fetch_instr(fetch_instr),
      .fetched_instr(fetched_instr),
      .fetched_addr(fetched_addr)
    );

  wire [DWIDTH-1:0] immediate;

  extensor
    extensor_inst (
      .instruction(fetched_instr),
      .immediate(immediate)
    );

endmodule
