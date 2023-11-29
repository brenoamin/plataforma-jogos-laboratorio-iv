//`include "arquivo_parametros.vh"

module sprits_finder_position (
	
	input wire clk,
	input wire rst,
	input wire active_finder_position,
	
	input wire [9:0] H_pos_in,					//Posição H e V
	input wire [9:0] V_pos_in,
	
	output reg active_high_four,
	output reg [5:0] high_four[3:0]

);
	// module sprits_finder_position
   //parameter [5:0] state_idle = 6'b000000;
   parameter [1:0] state_inicio = 2'b00;
   parameter [1:0] state_comparacao_perimetro = 2'b01;
   parameter [1:0] state_layers_prioritaria = 2'b10;
   parameter [1:0] state_controller_memory = 2'b11;
	parameter [5:0] no_sprite_id = 6'b111111; 
	
	
	integer count = 0;
	reg [5:0]actstate, nextstate;
		
	reg [5:0]sprit_found [31:0];
	reg [5:0]layer[31:0];						//sprits_id por layers
	reg [9:0]anchor_x[31:0];					//ancoras por sprit_id
	reg [9:0]anchor_y[31:0];



	initial begin
		active_high_four = 1'b0;
		high_four = '{default: '0};
		anchor_x = '{default: '0};
		anchor_y = '{default: '0};
		layer = '{default: '0};
		sprit_found = '{default: '0};			// Inicializa todos os bits como 0
	end


	always @(posedge clk or negedge rst) begin	// bloco de mudanca de estados
		if (!rst) begin
			actstate <= state_inicio;
		end else begin
			actstate <= nextstate;
		end	
	end

	always @(posedge clk) begin
		case (actstate) 
			
			state_inicio: begin
				
				active_high_four = 1'b0;
				high_four = '{default: '0};
				layer = '{default: '0};
				sprit_found = '{default: '0};

				if (active_finder_position == 1) begin
					nextstate <= state_comparacao_perimetro;
				end else begin
					nextstate <= state_inicio;
				end

			end	

			state_comparacao_perimetro: begin
				if (V_pos_in >= anchor_y[0] && V_pos_in <= anchor_y[0] + 15 && H_pos_in >= anchor_x[0] && H_pos_in <= anchor_x[0] + 15) begin
					sprit_found[0] <= layer[0];
				end 
				else begin
				if (V_pos_in >= anchor_y[1] && V_pos_in <= anchor_y[1] + 15 && H_pos_in >= anchor_x[1] && H_pos_in <= anchor_x[1] + 15) begin
					sprit_found[1] <= layer[1];
				end
				else begin					
				if (V_pos_in >= anchor_y[2] && V_pos_in <= anchor_y[2] + 15 && H_pos_in >= anchor_x[2] && H_pos_in <= anchor_x[2] + 15) begin
					sprit_found[2] <= layer[2];
				end
				else begin	
				if (V_pos_in >= anchor_y[3] && V_pos_in <= anchor_y[3] + 15 && H_pos_in >= anchor_x[3] && H_pos_in <= anchor_x[3] + 15) begin
					sprit_found[3] <= layer[3];
				end
				else begin
				if (V_pos_in >= anchor_y[4] && V_pos_in <= anchor_y[4] + 15 && H_pos_in >= anchor_x[4] && H_pos_in <= anchor_x[4] + 15) begin
					sprit_found[4] <= layer[4];
				end
				else begin
				if (V_pos_in >= anchor_y[5] && V_pos_in <= anchor_y[5] + 15 && H_pos_in >= anchor_x[5] && H_pos_in <= anchor_x[5] + 15) begin
					sprit_found[5] <= layer[5];
				end		
				else begin	
				if (V_pos_in >= anchor_y[6] && V_pos_in <= anchor_y[6] + 15 && H_pos_in >= anchor_x[6] && H_pos_in <= anchor_x[6] + 15) begin
					sprit_found[6] <= layer[6];
				end
				else begin	
				if (V_pos_in >= anchor_y[7] && V_pos_in <= anchor_y[7] + 15 && H_pos_in >= anchor_x[7] && H_pos_in <= anchor_x[7] + 15) begin
					sprit_found[7] <= layer[7];
				end
				else begin	
				if (V_pos_in >= anchor_y[8] && V_pos_in <= anchor_y[8] + 15 && H_pos_in >= anchor_x[8] && H_pos_in <= anchor_x[8] + 15) begin
					sprit_found[8] <= layer[8];
				end		
				else begin
				if (V_pos_in >= anchor_y[9] && V_pos_in <= anchor_y[9] + 15 && H_pos_in >= anchor_x[9] && H_pos_in <= anchor_x[9] + 15) begin
					sprit_found[9] <= layer[9];
				end	
				else begin
				if (V_pos_in >= anchor_y[10] && V_pos_in <= anchor_y[10] + 15 && H_pos_in >= anchor_x[10] && H_pos_in <= anchor_x[10] + 15) begin
					sprit_found[10] <= layer[10];
				end
				else begin
				if (V_pos_in >= anchor_y[11] && V_pos_in <= anchor_y[11] + 15 && H_pos_in >= anchor_x[11] && H_pos_in <= anchor_x[11] + 15) begin
					sprit_found[11] <= layer[11];
				end		
				else begin	
				if (V_pos_in >= anchor_y[12] && V_pos_in <= anchor_y[12] + 15 && H_pos_in >= anchor_x[12] && H_pos_in <= anchor_x[12] + 15) begin
					sprit_found[12] <= layer[12];
				end
				else begin
				if (V_pos_in >= anchor_y[13] && V_pos_in <= anchor_y[13] + 15 && H_pos_in >= anchor_x[13] && H_pos_in <= anchor_x[13] + 15) begin
					sprit_found[13] <= layer[13];
				end				
				else begin
				if (V_pos_in >= anchor_y[14] && V_pos_in <= anchor_y[14] + 15 && H_pos_in >= anchor_x[14] && H_pos_in <= anchor_x[14] + 15) begin
					sprit_found[14] <= layer[14];
				end			
				else begin
				if (V_pos_in >= anchor_y[15] && V_pos_in <= anchor_y[15] + 15 && H_pos_in >= anchor_x[15] && H_pos_in <= anchor_x[15] + 15) begin
					sprit_found[15] <= layer[15];
				end
				else begin
				if (V_pos_in >= anchor_y[16] && V_pos_in <= anchor_y[16] + 15 && H_pos_in >= anchor_x[16] && H_pos_in <= anchor_x[16] + 15) begin
					sprit_found[16] <= layer[16];
				end			
				else begin
				if (V_pos_in >= anchor_y[17] && V_pos_in <= anchor_y[17] + 15 && H_pos_in >= anchor_x[17] && H_pos_in <= anchor_x[17] + 15) begin
					sprit_found[17] <= layer[17];
				end
				else begin
				if (V_pos_in >= anchor_y[18] && V_pos_in <= anchor_y[18] + 15 && H_pos_in >= anchor_x[18] && H_pos_in <= anchor_x[18] + 15) begin
					sprit_found[18] <= layer[18];
				end				
				else begin
				if (V_pos_in >= anchor_y[19] && V_pos_in <= anchor_y[19] + 15 && H_pos_in >= anchor_x[19] && H_pos_in <= anchor_x[19] + 15) begin
					sprit_found[19] <= layer[19];
				end
				else begin
				if (V_pos_in >= anchor_y[20] && V_pos_in <= anchor_y[20] + 15 && H_pos_in >= anchor_x[20] && H_pos_in <= anchor_x[20] + 15) begin
					sprit_found[20] <= layer[20];
				end
				else begin
				if (V_pos_in >= anchor_y[21] && V_pos_in <= anchor_y[21] + 15 && H_pos_in >= anchor_x[21] && H_pos_in <= anchor_x[21] + 15) begin
					sprit_found[21] <= layer[21];
				end
				else begin
				if (V_pos_in >= anchor_y[22] && V_pos_in <= anchor_y[22] + 15 && H_pos_in >= anchor_x[22] && H_pos_in <= anchor_x[22] + 15) begin
					sprit_found[22] <= layer[22];
				end
				else begin
				if (V_pos_in >= anchor_y[23] && V_pos_in <= anchor_y[23] + 15 && H_pos_in >= anchor_x[23] && H_pos_in <= anchor_x[23] + 15) begin
					sprit_found[23] <= layer[23];
				end		
				else begin
				if (V_pos_in >= anchor_y[24] && V_pos_in <= anchor_y[24] + 15 && H_pos_in >= anchor_x[24] && H_pos_in <= anchor_x[24] + 15) begin
					sprit_found[24] <= layer[24];
				end			
				else begin	
				if (V_pos_in >= anchor_y[25] && V_pos_in <= anchor_y[25] + 15 && H_pos_in >= anchor_x[25] && H_pos_in <= anchor_x[25] + 15) begin
					sprit_found[25] <= layer[25];
				end			
				else begin
				if (V_pos_in >= anchor_y[26] && V_pos_in <= anchor_y[26] + 15 && H_pos_in >= anchor_x[26] && H_pos_in <= anchor_x[26] + 15) begin
					sprit_found[26] <= layer[26];
				end			
				else begin
				if (V_pos_in >= anchor_y[27] && V_pos_in <= anchor_y[27] + 15 && H_pos_in >= anchor_x[27] && H_pos_in <= anchor_x[27] + 15) begin
					sprit_found[27] <= layer[27];
				end				
				else begin
				if (V_pos_in >= anchor_y[28] && V_pos_in <= anchor_y[28] + 15 && H_pos_in >= anchor_x[28] && H_pos_in <= anchor_x[28] + 15) begin
					sprit_found[28] <= layer[28];
				end
				else begin
				if (V_pos_in >= anchor_y[29] && V_pos_in <= anchor_y[29] + 15 && H_pos_in >= anchor_x[29] && H_pos_in <= anchor_x[29] + 15) begin
					sprit_found[29] <= layer[29];
				end			
				else begin
				if (V_pos_in >= anchor_y[30] && V_pos_in <= anchor_y[30] + 15 && H_pos_in >= anchor_x[30] && H_pos_in <= anchor_x[30] + 15) begin
					sprit_found[30] <= layer[30];
				end				
				else begin
				if (V_pos_in >= anchor_y[31] && V_pos_in <= anchor_y[31] + 15 && H_pos_in >= anchor_x[31] && H_pos_in <= anchor_x[31] + 15) begin
					sprit_found[31] <= layer[31];
				end
				nextstate <= state_layers_prioritaria;

				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
				end
			

			state_layers_prioritaria: begin

				for (integer i = 31; i >= 0; i = i - 1) begin
					if (sprit_found[i] != no_sprite_id) begin
						high_four[count] <= sprit_found[i];
						count <= count + 1;
					end

					// Se encontrou 4 valores diferentes, encerra o loop
					if (count == 4) begin
						nextstate <= state_controller_memory;
						active_high_four <= 1;
						//$display("Encontrou 4 valores diferentes de no_sprite_id");
						//$finish; // Encerra a simulação
					end
				end
			end

			state_controller_memory: begin
				nextstate <= state_inicio;
				active_high_four <= 0;
			end

			default: nextstate <= state_inicio;
			
		endcase
	end
endmodule