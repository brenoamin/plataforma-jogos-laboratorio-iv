//`include "arquivo_parametros.vh"

module count_px_clk(
    input wire clk,
    input wire rst,
    input wire pixel_clk,
    input wire h_sync,
    output reg [9:0] h_pos_out,
    output reg active_finder_position
);

// module count_px_clk
   parameter [1:0] state_idle  = 2'b00;
   parameter [1:0] state_counting_pixel  = 2'b01;
   parameter [1:0] state_counting_640 = 2'b10;
   parameter [1:0] state_reset  = 2'b11;

	
	reg [1:0] actstate, nextstate;

	initial begin									// bloco inicital para saidas
		nextstate = state_idle;
		actstate = state_idle;
	   	h_pos_out = 0;
     		active_finder_position = 0;
	end
	
	always @(posedge pixel_clk) begin
		h_pos_out <= h_pos_out + 1;
		if (h_pos_out > 640) h_pos_out <= 0;
	end

	always @(posedge h_sync) h_pos_out <= 0;


endmodule


