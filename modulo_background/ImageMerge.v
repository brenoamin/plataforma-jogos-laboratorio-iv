module ImageMerge(
  input wire [7:0] sdram_R, // Componente vermelha da SDRAM
  input wire [7:0] sdram_G, // Componente verde da SDRAM
  input wire [7:0] sdram_B, // Componente azul da SDRAM
  input wire [7:0] sprite_R, // Componente vermelha do sprite
  input wire [7:0] sprite_G, // Componente verde do sprite
  input wire [7:0] sprite_B, // Componente azul do sprite
  input wire [7:0] alpha, // Componente de opacidade do sprite (0 = transparente, 255 = opaco)
  output reg [7:0] merged_R, // Componente vermelha do resultado
  output reg [7:0] merged_G, // Componente verde do resultado
  output reg [7:0] merged_B  // Componente azul do resultado
);

  // Lógica para combinar as cores dos pixels com base no alpha
  always @* begin
    // Mescle as cores da SDRAM e do sprite com base no valor de alpha
    merged_R = (alpha * sprite_R + (255 - alpha) * sdram_R) >> 8;
    merged_G = (alpha * sprite_G + (255 - alpha) * sdram_G) >> 8;
    merged_B = (alpha * sprite_B + (255 - alpha) * sdram_B) >> 8;
	 
// Nesse trecho, a fórmula calcula a contribuição da cor do sprite e da SDRAM para o resultado final, levando em consideração o valor do canal alfa.
// Quando o canal alfa é igual a 255, o sprite é totalmente opaco, e sua cor contribui totalmente para o resultado.
// Quando o canal alfa é igual a 0, o sprite é totalmente transparente, e a cor da SDRAM permanece visível.
// Portanto, o canal alfa permite controlar a opacidade do sprite e, assim, a sobreposição da imagem do sprite sobre a imagem de fundo da SDRAM.
// Isso é útil para criar efeitos visuais onde partes do sprite podem ser transparentes, permitindo que a imagem de fundo da SDRAM seja vista através delas.

  end

endmodule
//O alfa tá sendo usado para efeitos de transição para controlar a transparência gradual de um objeto ao longo do tempo.

//Também pode ser usado para suavizar bordas irregulares em objetos, o que é conhecido como antialiasing. Isso ajuda a tornar as imagens mais nítidas e com bordas mais suaves