`include "arquivo_parametros.vh"

module sprits_finder_position (
	
	input wire clk,
	input wire rst,
	input wire active_finder_position,
	
	input wire [9:0] H_pos_in,					//Posição H e V
	input wire [9:0] V_pos_in,

//verificar o formato
//pode ficar como entrada mas preciso ter armazenado tbm
	input wire [9:0]anchor_x[31:0],				//ancoras por sprit_id
	input wire [9:0]anchor_y[31:0],
	input wire [5:0]layer[31:0],				//sprits_id por layers
	
	output reg ready_high_four,
	output reg [5:0] high_four[3:0]

);

	reg [3:0] index;
	reg [5:0] sprit_found [31:0];
	reg [5:0] actstate, nextstate;


	initial begin
		ready_high_four = 1'b0;
		high_four = '{default: '0};
		index = 3'd3;
		sprit_found = '{default: '0};					// Inicializa todos os bits como 0
	end


	always @(posedge clk or negedge rst) begin			// bloco de mudanca de estados
		if (!rst) begin
			actstate <= state_idle;
		end 
		else begin
			actstate <= nextstate;
		end
	end	
	

	always @(posedge clk or posedge active) begin

		case (actstate)
			
			state_idle: begin
				
				sprit_found = 32'b0; 					// Inicializa todos os bits como 0
				ready_high_four = 1'b0;
				index = 3'd3;


				if (active_finder_position) begin
					nextstate <= finder_position;
				end
				else begin
					 sprit_found <= 32'b0;
					 nextstate <= state_idle;
				end
			end	

			finder_position: begin
				if (V_pos_in >= anchor_y[0] && V_pos_in <= anchor_y[0] + 15 & H_pos_in >= anchor_x[0] && H_pos_in <= anchor_x[0] + 15) begin
					sprit_found[0] <= layer[0];
				end
					
				if (V_pos_in >= anchor_y[1] && V_pos_in <= anchor_y[1] + 15 & H_pos_in >= anchor_x[1] && H_pos_in <= anchor_x[1] + 15) begin
					sprit_found[1] <= layer[1];
				end
									
				if (V_pos_in >= anchor_y[2] && V_pos_in <= anchor_y[2] + 15 & H_pos_in >= anchor_x[2] && H_pos_in <= anchor_x[2] + 15) begin
					sprit_found[2] <= layer[2];
				end
					
				if (V_pos_in >= anchor_y[3] && V_pos_in <= anchor_y[3] + 15 & H_pos_in >= anchor_x[3] && H_pos_in <= anchor_x[3] + 15) begin
					sprit_found[3] <= layer[3];
				end
				
				if (V_pos_in >= anchor_y[4] && V_pos_in <= anchor_y[4] + 15 & H_pos_in >= anchor_x[4] && H_pos_in <= anchor_x[4] + 15) begin
					sprit_found[4] <= layer[4];
				end
			
				if (V_pos_in >= anchor_y[5] && V_pos_in <= anchor_y[5] + 15 & H_pos_in >= anchor_x[5] && H_pos_in <= anchor_x[5] + 15) begin
					sprit_found[5] <= layer[5];
				end		
					
				if (V_pos_in >= anchor_y[6] && V_pos_in <= anchor_y[6] + 15 & H_pos_in >= anchor_x[6] && H_pos_in <= anchor_x[6] + 15) begin
					sprit_found[6] <= layer[6];
				end
					
				if (V_pos_in >= anchor_y[7] && V_pos_in <= anchor_y[7] + 15 & H_pos_in >= anchor_x[7] && H_pos_in <= anchor_x[7] + 15) begin
					sprit_found[7] <= layer[7];
				end
					
				if (V_pos_in >= anchor_y[8] && V_pos_in <= anchor_y[8] + 15 & H_pos_in >= anchor_x[8] && H_pos_in <= anchor_x[8] + 15) begin
					sprit_found[8] <= layer[8];
				end		

				if (V_pos_in >= anchor_y[9] && V_pos_in <= anchor_y[9] + 15 & H_pos_in >= anchor_x[9] && H_pos_in <= anchor_x[9] + 15) begin
					sprit_found[9] <= layer[9];
				end	

				if (V_pos_in >= anchor_y[10] && V_pos_in <= anchor_y[10] + 15 && H_pos_in >= anchor_x[10] && H_pos_in <= anchor_x[10] + 15) begin
					sprit_found[10] <= layer[10];
				end

				if (V_pos_in >= anchor_y[11] && V_pos_in <= anchor_y[11] + 15 && H_pos_in >= anchor_x[11] && H_pos_in <= anchor_x[11] + 15) begin
					sprit_found[11] <= layer[11];
				end		
					
				if (V_pos_in >= anchor_y[12] && V_pos_in <= anchor_y[12] + 15 && H_pos_in >= anchor_x[12] && H_pos_in <= anchor_x[12] + 15) begin
					sprit_found[12] <= layer[12];
				end

				if (V_pos_in >= anchor_y[13] && V_pos_in <= anchor_y[13] + 15 && H_pos_in >= anchor_x[13] && H_pos_in <= anchor_x[13] + 15) begin
					sprit_found[13] <= layer[13];
				end				
				
				if (V_pos_in >= anchor_y[14] && V_pos_in <= anchor_y[14] + 15 && H_pos_in >= anchor_x[14] && H_pos_in <= anchor_x[14] + 15) begin
					sprit_found[14] <= layer[14];
				end			

				if (V_pos_in >= anchor_y[15] && V_pos_in <= anchor_y[15] + 15 && H_pos_in >= anchor_x[15] && H_pos_in <= anchor_x[15] + 15) begin
					sprit_found[15] <= layer[15];
				end

				if (V_pos_in >= anchor_y[16] && V_pos_in <= anchor_y[16] + 15 && H_pos_in >= anchor_x[16] && H_pos_in <= anchor_x[16] + 15) begin
					sprit_found[16] <= layer[16];
				end			

				if (V_pos_in >= anchor_y[17] && V_pos_in <= anchor_y[17] + 15 && H_pos_in >= anchor_x[17] && H_pos_in <= anchor_x[17] + 15) begin
					sprit_found[17] <= layer[17];
				end

				if (V_pos_in >= anchor_y[18] && V_pos_in <= anchor_y[18] + 15 && H_pos_in >= anchor_x[18] && H_pos_in <= anchor_x[18] + 15) begin
					sprit_found[18] <= layer[18];
				end				

				if (V_pos_in >= anchor_y[19] && V_pos_in <= anchor_y[19] + 15 && H_pos_in >= anchor_x[19] && H_pos_in <= anchor_x[19] + 15) begin
					sprit_found[19] <= layer[19];
				end
				
				if (V_pos_in >= anchor_y[20] && V_pos_in <= anchor_y[20] + 15 && H_pos_in >= anchor_x[20] && H_pos_in <= anchor_x[20] + 15) begin
					sprit_found[20] <= layer[20];
				end

				if (V_pos_in >= anchor_y[21] && V_pos_in <= anchor_y[21] + 15 && H_pos_in >= anchor_x[21] && H_pos_in <= anchor_x[21] + 15) begin
					sprit_found[21] <= layer[21];
				end

				if (V_pos_in >= anchor_y[22] && V_pos_in <= anchor_y[22] + 15 && H_pos_in >= anchor_x[22] && H_pos_in <= anchor_x[22] + 15) begin
					sprit_found[22] <= layer[22];
				end

				if (V_pos_in >= anchor_y[23] && V_pos_in <= anchor_y[23] + 15 && H_pos_in >= anchor_x[23] && H_pos_in <= anchor_x[23] + 15) begin
					sprit_found[23] <= layer[23];
				end		

				if (V_pos_in >= anchor_y[24] && V_pos_in <= anchor_y[24] + 15 && H_pos_in >= anchor_x[24] && H_pos_in <= anchor_x[24] + 15) begin
					sprit_found[24] <= layer[24];
				end			
					
				if (V_pos_in >= anchor_y[25] && V_pos_in <= anchor_y[25] + 15 && H_pos_in >= anchor_x[25] && H_pos_in <= anchor_x[25] + 15) begin
					sprit_found[25] <= layer[25];
				end			

				if (V_pos_in >= anchor_y[26] && V_pos_in <= anchor_y[26] + 15 && H_pos_in >= anchor_x[26] && H_pos_in <= anchor_x[26] + 15) begin
					sprit_found[26] <= layer[26];
				end			

				if (V_pos_in >= anchor_y[27] && V_pos_in <= anchor_y[27] + 15 && H_pos_in >= anchor_x[27] && H_pos_in <= anchor_x[27] + 15) begin
					sprit_found[27] <= layer[27];
				end				

				if (V_pos_in >= anchor_y[28] && V_pos_in <= anchor_y[28] + 15 && H_pos_in >= anchor_x[28] && H_pos_in <= anchor_x[28] + 15) begin
					sprit_found[28] <= layer[28];
				end

				if (V_pos_in >= anchor_y[29] && V_pos_in <= anchor_y[29] + 15 && H_pos_in >= anchor_x[29] && H_pos_in <= anchor_x[29] + 15) begin
					sprit_found[29] <= layer[29];
				end			

				if (V_pos_in >= anchor_y[30] && V_pos_in <= anchor_y[30] + 15 && H_pos_in >= anchor_x[30] && H_pos_in <= anchor_x[30] + 15) begin
					sprit_found[30] <= layer[30];
				end				

				if (V_pos_in >= anchor_y[31] && V_pos_in <= anchor_y[31] + 15 && H_pos_in >= anchor_x[31] && H_pos_in <= anchor_x[31] + 15) begin
					sprit_found[31] <= layer[31];
				end
				nextstate <= high_four;
			end

			high_four_31: begin
				if (sprit_found[31] != no_id_sprit) begin
					high_four[index] <= sprit_found[31];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_30;
					end
				end
			end

			high_four_30: begin
				if (sprit_found[30] != no_id_sprit) begin
					high_four[index] <= sprit_found[30];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_29;
					end
				end
			end

			high_four_29: begin
				if (sprit_found[29] != no_id_sprit) begin
					high_four[index] <= sprit_found[29];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_28;
					end
				end
			end

			high_four_28: begin
				if (sprit_found[28] != no_id_sprit) begin
					high_four[index] <= sprit_found[28];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_27;
					end
				end
			end

			high_four_27: begin
				if (sprit_found[27] != no_id_sprit) begin
					high_four[index] <= sprit_found[27];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_26;
					end
				end
			end

			high_four_26: begin
				if (sprit_found[26] != no_id_sprit) begin
					high_four[index] <= sprit_found[26];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_25;
					end
				end
			end

			high_four_25: begin
				if (sprit_found[25] != no_id_sprit) begin
					high_four[index] <= sprit_found[25];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_24;
					end
				end
			end

			high_four_24: begin
				if (sprit_found[24] != no_id_sprit) begin
					high_four[index] <= sprit_found[24];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_23;
					end
				end
			end

			high_four_23: begin
				if (sprit_found[23] != no_id_sprit) begin
					high_four[index] <= sprit_found[23];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_22;
					end
				end
			end


			high_four_22: begin
				if (sprit_found[22] != no_id_sprit) begin
					high_four[index] <= sprit_found[22];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_21;
					end
				end
			end

			high_four_21: begin
				if (sprit_found[21] != no_id_sprit) begin
					high_four[index] <= sprit_found[21];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_20;
					end
				end
			end

			high_four_20: begin
				if (sprit_found[20] != no_id_sprit) begin
					high_four[index] <= sprit_found[20];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_19;
					end
				end
			end


			high_four_19: begin
				if (sprit_found[19] != no_id_sprit) begin
					high_four[index] <= sprit_found[19];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_18;
					end
				end
			end

			high_four_18: begin
				if (sprit_found[18] != no_id_sprit) begin
					high_four[index] <= sprit_found[18];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_17;
					end
				end
			end


			high_four_17: begin
				if (sprit_found[17] != no_id_sprit) begin
					high_four[index] <= sprit_found[17];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_16;
					end
				end
			end

			high_four_16: begin
				if (sprit_found[16] != no_id_sprit) begin
					high_four[index] <= sprit_found[16];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_15;
					end
				end
			end


			high_four_15: begin
				if (sprit_found[15] != no_id_sprit) begin
					high_four[index] <= sprit_found[15];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_14;
					end
				end
			end


			high_four_14: begin
				if (sprit_found[14] != no_id_sprit) begin
					high_four[index] <= sprit_found[14];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_13;
					end
				end
			end


			high_four_13: begin
				if (sprit_found[13] != no_id_sprit) begin
					high_four[index] <= sprit_found[13];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_12;
					end
				end
			end



			high_four_12: begin
				if (sprit_found[12] != no_id_sprit) begin
					high_four[index] <= sprit_found[12];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_11;
					end
				end
			end


			high_four_11: begin
				if (sprit_found[11] != no_id_sprit) begin
					high_four[index] <= sprit_found[11];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_10;
					end
				end
			end


			high_four_10: begin
				if (sprit_found[10] != no_id_sprit) begin
					high_four[index] <= sprit_found[10];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_9;
					end
				end
			end


			high_four_9: begin
				if (sprit_found[9] != no_id_sprit) begin
					high_four[index] <= sprit_found[9];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_8;
					end
				end
			end


			high_four_8: begin
				if (sprit_found[8] != no_id_sprit) begin
					high_four[index] <= sprit_found[8];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_7;
					end
				end
			end


			high_four_7: begin
				if (sprit_found[7] != no_id_sprit) begin
					high_four[index] <= sprit_found[7];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_6;
					end
				end
			end

			high_four_6: begin
				if (sprit_found[6] != no_id_sprit) begin
					high_four[index] <= sprit_found[6];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_5;
					end
				end
			end


			high_four_5: begin
				if (sprit_found[5] != no_id_sprit) begin
					high_four[index] <= sprit_found[5];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_4;
					end
				end
			end

			high_four_4: begin
				if (sprit_found[4] != no_id_sprit) begin
					high_four[index] <= sprit_found[4];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_3;
					end
				end
			end


			high_four_3: begin
				if (sprit_found[3] != no_id_sprit) begin
					high_four[index] <= sprit_found[3];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_2;
					end
				end
			end



			high_four_2: begin
				if (sprit_found[2] != no_id_sprit) begin
					high_four[index] <= sprit_found[2];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;
						nextstate <= high_four_1;
					end
				end
			end


			high_four_1: begin
				if (sprit_found[1] != no_id_sprit) begin
					high_four[index] <= sprit_found[1];
					if (index != 3 && index != 2 && index != 1 && index != 0 ) begin
						nextstate <= send_high_four;
					end else begin
						index = index - 1'b1;	
						nextstate <= high_four_0;
					end
				end
			end


			high_four_0: begin
				if (sprit_found[0] != no_id_sprit) begin
					high_four[index] <= sprit_found[0];
				end
				nextstate <= send_high_four;
			end

			send_high_four: begin
				ready_high_four <= 1'b1;
				nextstate <= state_idle;
			end

		endcase
	end
endmodule
