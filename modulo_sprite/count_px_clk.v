//`include "arquivo_parametros.vh"

module count_px_clk(
    input wire clk,
    input wire rst,
    input wire pixel_clk,
    input wire h_sync,
    output reg [9:0] H_pos_in,
    output reg active_finder_position
);

// module count_px_clk
   parameter [1:0] state_idle  = 2'b00;
   parameter [1:0] state_counting_pixel  = 2'b01;
   parameter [1:0] state_counting_640 = 2'b10;
	
	
	reg [1:0] actstate, nextstate;

	initial begin									// bloco inicital para saidas
		nextstate = state_idle;
		actstate = state_idle;
	    H_pos_in = 0;
        active_finder_position = 0;
	end


	always @(posedge clk or negedge rst) begin
		if (rst) begin
			actstate <= state_idle;
            H_pos_in = 0;
            active_finder_position = 0;
        end	else begin
			actstate <= nextstate;
        end
	end	

	always @(posedge clk) begin

		case (actstate)

            state_idle: begin

                H_pos_in = 0;
                active_finder_position = 0;
                
                if (h_sync == 1) begin
                    nextstate <= state_counting_pixel;
                    H_pos_in <= H_pos_in + 1;
                    active_finder_position <= 1;
                end else begin
                    nextstate <= state_idle;
                    active_finder_position <= 0;
                end
            end

            state_counting_pixel: begin
                if (pixel_clk == 1) begin
                    H_pos_in <= H_pos_in + 1;
                    active_finder_position <= 1;
                    if (H_pos_in >= 639) begin
                        H_pos_in <= 0;
                        nextstate <= state_counting_640;
                    end else begin
                        nextstate <= state_counting_pixel;
                    end

                end 
            end

            state_counting_640: begin
                active_finder_position <= 0;
                nextstate <= state_idle;
            end

            default: nextstate <= state_idle;

        endcase
	end	

endmodule

