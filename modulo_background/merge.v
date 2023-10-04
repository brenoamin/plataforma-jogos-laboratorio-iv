module merge (
  input wire [7:0] background_image [639*480],
  input wire [7:0] sprite_image [639*480],
  output wire [7:0] combined_image [639*480]
);
endmodule

// Declaração de matrizes compactadas
/*input wire [7:0] background_image;
input wire [7:0] sprite_image;
output wire [7:0] combined_image;

// Declaração de constantes
parameter SPRITE_X = 10;
parameter SPRITE_Y = 20;

// Atribuição de cores
always @(*) begin
// Inicialize as cores do pixel com as cores do plano de fundo
pixel_R = background_image[sprite_x][sprite_y];
pixel_G = background_image[sprite_x][sprite_y];
pixel_B = background_image[sprite_x][sprite_y];

// Verifique se o sprite está na área visível

a condição de entrada se for transparente(Rosa) 255 102 204


if (*) begin
  // Combinar as cores do sprite com as cores do plano de fundo
  pixel_R = (sprite_image[sprite_x][sprite_y] == 0) ? pixel_R : sprite_image[sprite_x][sprite_y];
  pixel_G = (sprite_image[sprite_x][sprite_y] == 0) ? pixel_G : sprite_image[sprite_x][sprite_y];
  pixel_B = (sprite_image[sprite_x][sprite_y] == 0) ? pixel_B : sprite_image[sprite_x][sprite_y];
end
end

// Saída combinada
assign combined_image[sprite_x][sprite_y] = pixel_R;
assign combined_image[sprite_x][sprite_y] = pixel_G;
assign combined_image[sprite_x][sprite_y] = pixel_B;

/*endmodule