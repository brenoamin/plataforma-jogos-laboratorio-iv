////UNIVERSIDADE FEDERAL DA BAHIA
////CÓDIGO REFERENTE A FINS AVALIATIVOS NA DISCIPLINA DE LABIV
////ALUNO: JOÃO RIOS
module prepara_dados(
input clock,
input rst,
input [17:0] data_in,
output reg [3:0] anchor_y,
output reg [3:0] anchor_x,
output reg [4:0] sprite_layer,
output reg [4:0] sprite_id
); 


always @(posedge clock or posedge rst) 
begin 
	if (rst) begin 
	anchor_y <= 0;
	anchor_x <= 0;
	sprite_layer <= 0;
	sprite_id <= 0;
		end else begin
		anchor_y <= data_in[13:10];
		anchor_x <= data_in [17:14];
		sprite_layer <= data_in[9:5];
		sprite_id <= data_in[4:0];
		end
end

endmodule 