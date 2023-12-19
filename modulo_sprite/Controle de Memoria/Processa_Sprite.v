////UNIVERSIDADE FEDERAL DA BAHIA
////CÓDIGO REFERENTE A FINS AVALIATIVOS NA DISCIPLINA DE LABIV
////ALUNO: JOÃO RIOS

module Processa_Sprite (
input clock,
input reset,
input [3:0] anchor_x,
input  [3:0]anchor_y,
input [4:0] sprite_id,

output reg wren,
output reg [12:0] addr
);

reg [23:0] layer0 [255:0];
reg [23:0] layer1 [255:0];
reg [23:0] layer2 [255:0];
reg [23:0] layer3 [255:0];
reg [7:0]busca_linha;
reg [7:0]busca_pixel;
reg [23:0] layer [31:0];
reg [23:0] layer_merge [3:0];
reg [4:0] i;
//
always @ (*)
begin
busca_linha = anchor_y*16;
busca_pixel = busca_linha + anchor_x;
addr = busca_pixel+ 256*sprite_id;

end

always @ (posedge clock)
begin

	wren <= 0;

	
end

endmodule 