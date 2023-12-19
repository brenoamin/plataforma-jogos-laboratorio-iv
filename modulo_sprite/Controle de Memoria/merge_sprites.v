////UNIVERSIDADE FEDERAL DA BAHIA
////CÓDIGO REFERENTE A FINS AVALIATIVOS NA DISCIPLINA DE LABIV
////ALUNO: JOÃO RIOS
module merge_sprites (
input clock,
input reset,
input [4:0] sprite_id,
input [4:0] sprite_layer,
input [23:0] data,

output reg [23:0] pixel,
output reg [7:0] Saida_R,
output reg [7:0] Saida_G,
output reg [7:0] Saida_B

);


reg [23:0] memory_layer[3:0]; 
integer  i;
reg [23:0] saida;
always @(*) begin 

	if(sprite_layer <= 3) begin
	
	memory_layer[sprite_layer] = data;
		for(i = 3  ; i>=0 ; i = i-1) begin
			
			if(memory_layer[i] != 17) begin
			saida = memory_layer[i];
			 end
			
		end
	end
	
	pixel = saida;
	Saida_R = saida[7:0];
   Saida_G = saida[15:8];
   Saida_B = saida[23:16];
	end 
	
	
	endmodule 
	
