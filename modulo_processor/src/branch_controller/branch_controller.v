`include "src/branch_controller/stack/stack.v"

module branch_controller#(
    parameter integer DWIDTH = 32,
    parameter integer AWIDTH = 15  //! Largura do endereço da memória
  )(
    input wire clk, rst,  //! Clock and reset inputs
    input wire [AWIDTH - 1:0] addr,
    input wire [DWIDTH - 1:0] immediate, rd, instr,
    output reg [DWIDTH - 1:0] r_abs,
    output wire full, empty
  );

  reg pop, push;
  wire full_stack, empty_stack;
  wire [AWIDTH - 1:0] data_out_stack;

  localparam JR   = 5'b01101;
  localparam JPC  = 5'b01110;
  localparam BRFL = 5'b01111;
  localparam CALL = 5'b10000;
  localparam RET  = 5'b10001;

  // Instantiate the Design Under Test (DUT)
  stack #(
          .WIDTH(AWIDTH),
          .DEPTH(32)
        ) stack (
          .clk(clk),
          .rst(rst),
          .pop(pop),
          .push(push),
          .empty(empty),
          .full(full),
          .data_in(addr),
          .data_out(data_out_stack)
        );

  always @(*)
  begin: BRANCH_CONTROLLER
    case (instr[DWIDTH - 1:DWIDTH - 5])
      JR, BRFL:
      begin
        pop = 0;
        push = 0;
        r_abs = rd;
      end
      JPC:
      begin
        pop = 0;
        push = 0;
        r_abs = immediate + rd + 1;
      end
      CALL:
      begin
        pop = 0;
        push = 1;
        r_abs = rd;
      end
      RET:
      begin
        push = 0;
        pop = 1;
        r_abs = data_out_stack;
      end
      default:
      begin
        pop = 0;
        push = 0;
      end
    endcase
  end

endmodule
