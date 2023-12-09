//`include "arquivo_parametros.vh"

module sprits_finder_position (
	
	input wire clk,
	input wire rst,
	input wire active_finder_position,

	input wire [9:0] H_pos_in,					//Posição H e V
	input wire [9:0] V_pos_in,
	
	input wire active_function_processor,
	input wire [1:0] function_selector,
	input wire [5:0] function_id_sprit,
	input wire [9:0] function_col,
	input wire [9:0] function_row,
	input wire [5:0] function_input01,
	input wire [5:0] function_input02,
	
	output reg active_high_four,
	output reg [5:0] high_four01,
	output reg [5:0] high_four02,
	output reg [5:0] high_four03,
	output reg [5:0] high_four04,

	output reg function_sp_colision_out
);
	// module sprits_finder_position

	parameter [3:0] state_inicio = 4'b0000;
	parameter [3:0] state_comparacao_perimetro = 4'b0001;
	parameter [3:0] state_layers_prioritaria = 4'b0010;
	parameter [3:0] state_controller_memory = 4'b0011;	

	parameter [3:0] state_selector_function = 4'b0100;
	parameter [3:0] state_funcition_sp_level = 4'b0101;
	parameter [3:0] state_function_sp_pos = 4'b0110;
	parameter [3:0] state_function_sp_colision = 4'b0111;
	parameter [3:0] state_function_sp_colision_out = 4'b1000;
	parameter [3:0] state_reset = 4'b1001;

	parameter [1:0] function_sprite_level = 2'b00;
	parameter [1:0] function_sprite_pos = 2'b01;
	parameter [1:0] function_sprite_colision = 2'b10;
	
	parameter [5:0] no_sprite_id = 6'b111111; 
	
	
	integer count = 0;
	integer j = 0;
	integer m = 0;

	reg [3:0]actstate, nextstate;
	reg encontrado_sprite_1, encontrado_sprite_2;
		
	reg [5:0]sprit_found [31:0];
	reg [5:0]layer[31:0];						//sprits_id por layers
	reg [5:0]valor_matriz;
	reg signed [5:0]i;
	reg [9:0]anchor_x[31:0];					//ancoras por sprit_id
	reg [9:0]anchor_y[31:0];

	reg [5:0] high_four[3:0];


	initial begin
		active_high_four = 1'b0;
		high_four[0] = 6'b0;
		high_four[1] = 6'b0;
		high_four[2] = 6'b0;
		high_four[3] = 6'b0;
		layer[0] = 6'b0;
		layer[1] = 6'b0;
		layer[2] = 6'b0;
		layer[3] = 6'b0;	
		sprit_found[0] = 6'b0;
		sprit_found[1] = 6'b0;
		sprit_found[2] = 6'b0;
		sprit_found[3] = 6'b0;		// Inicializa todos os bits como 0
		function_sp_colision_out = 1'b0;
		valor_matriz = 0;
		count = 0;
i = 0;
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
			
			state_reset: begin
        			//for (m <= 0; m < 32; m <= m + 1) begin
           				//anchor_x[m] <= 10'b0; // Inicializao de anchor_x com zero
            			//	anchor_y[m] <= 10'b0; // Inicializao de anchor_y com zero
        			//end
					active_high_four <= 1'b0;
					high_four[0] <= 6'b0;
					high_four[1] <= 6'b0;
					high_four[2] <= 6'b0;
					high_four[3] <= 6'b0;
					layer[0] <= 6'b0;
					layer[1] <= 6'b0;
					layer[2] <= 6'b0;
					layer[3] <= 6'b0;	
					sprit_found[0] <= 6'b0;
					sprit_found[1] <= 6'b0;
					sprit_found[2] <= 6'b0;
					sprit_found[3] <= 6'b0;		// Inicializa todos os bits como 0
					function_sp_colision_out <= 1'b0;
					valor_matriz <= 0;
					count <= 0;
					i <= 0;
			end
			
			state_inicio: begin
				
				active_high_four = 1'b0;
				//high_four = '{default: '0};
				//layer = '{default: '0};
				//sprit_found = '{default: '0};

				if (active_finder_position == 1) begin
					nextstate <= state_comparacao_perimetro;
				end else begin
					if (active_function_processor == 1) begin
						nextstate <= state_selector_function;
					end
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

				for (i = 31; i >= 0; i = i - 1) begin
					if (layer[i] != no_sprite_id) begin
						high_four[count] <= sprit_found[i];
						count <= count + 1;
					end
				end
					// Se encontrou 4 valores diferentes, encerra o loop
					if (count == 4) begin
						high_four[0] <= high_four01;
						high_four[1] <= high_four02;
						high_four[2] <= high_four03;
						high_four[3] <= high_four04;
						nextstate <= state_controller_memory;
						active_high_four <= 1;
					end
			end

			state_controller_memory: begin
				nextstate <= state_inicio;
				active_high_four <= 0;
			end
			
			state_selector_function: begin
				case(function_selector)
				
					function_sprite_level: begin
						nextstate <= state_funcition_sp_level;
					end
					
					function_sprite_pos: begin
						nextstate <= state_function_sp_pos;
					end
					
					function_sprite_colision: begin
						nextstate <= state_function_sp_colision;
					end
			
				endcase
			end
			
			state_funcition_sp_level: begin
				layer[function_id_sprit] = function_id_sprit;
				nextstate <= state_inicio;
			end
			
			state_function_sp_pos: begin
				anchor_x[function_id_sprit] = function_row;
				anchor_y[function_id_sprit] = function_col;
				nextstate <= state_inicio;
			end
			
			state_function_sp_colision: begin
				//encontrado = 0; // Inicializa a variável de controle de encontrado
				// Acessando cada elemento da matriz individualmente
				for (j = 0; j < 32; j = j + 1) begin
					valor_matriz = layer[j]; // Acessa a linha i da matriz
					if (valor_matriz == function_input01) begin
							 encontrado_sprite_1 = 1; // Valor encontrado
					end
					if (valor_matriz == function_input02) begin
							 encontrado_sprite_2 = 1; // Valor encontrado
					end
				end
				
				if (encontrado_sprite_1 & encontrado_sprite_2) begin
					nextstate <= state_function_sp_colision_out;
				end
				else begin
					nextstate <= state_inicio;
				end
				
			end
			
			state_function_sp_colision_out: begin
				function_sp_colision_out = 1;
				nextstate <= state_inicio;
			end
			
			default: nextstate <= state_inicio;
			
		endcase
	end
endmodule

// 