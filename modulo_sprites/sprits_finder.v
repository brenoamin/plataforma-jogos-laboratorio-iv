`include "arquivo_parametros.vh"

module sprits_finder (

	output reg layer [31:0];
	
	//Posição H e V
	input wire [9:0] H_pos_in;
	input wire [9:0] V_pos_in;

	//ancoras por sprit_id
	input wire [9:0]anchor_x[31:0];
	input wire [9:0]anchor_y[31:0];


	input [9:0] pixel_count;
	input [8:0] line_count

);


initial begin

	
end

endmodule