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
	

	always @(posedge clk or negedge rst) begin
		
		if (!rst) begin
			actstate <= state_idle;
         h_pos_out <= 0;
         active_finder_position <= 0;
		end
		else begin
			actstate <= nextstate;
		end
		
		case (actstate)
				
				state_reset: begin
					h_pos_out <= 0;
               active_finder_position <= 0;
					nextstate <= state_idle;
				end
				
            state_idle: begin
                
                if (h_sync == 1) begin
                    nextstate <= state_counting_pixel;
                    h_pos_out <= h_pos_out + 1'b1;
                    active_finder_position <= 1;
                end
            end

            state_counting_pixel: begin
                if (pixel_clk == 1) begin
						  h_pos_out <= h_pos_out + 1'b1;
                    active_finder_position <= 1;
                    if (h_pos_out >= 639) begin
                        h_pos_out <= 0;
                        nextstate <= state_counting_640;
                    end else begin
                        nextstate <= state_counting_pixel;
                    end

                end 
            end

            state_counting_640: begin
					 h_pos_out <= 0;
                active_finder_position <= 0;
                nextstate <= state_idle;
            end

            default: nextstate <= state_idle;

        endcase
	end	

endmodule

