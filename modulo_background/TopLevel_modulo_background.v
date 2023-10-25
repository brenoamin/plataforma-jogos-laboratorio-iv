module TopLevel_modulo_background(
  // Entradas
  input wire clk,
  input wire rst,
  input wire [7:0] R_in,
  input wire [7:0] G_in,
  input wire [7:0] B_in,
  input wire sprite_valid,
  input wire [7:0] sprite_R,
  input wire [7:0] sprite_G,
  input wire [7:0] sprite_B,
  input wire [7:0] sdram_R,
  input wire [7:0] sdram_G,
  input wire [7:0] sdram_B,

  // Saídas
  output wire [7:0] R,
  output wire [7:0] G,
  output wire [7:0] B,
  output wire HS,
  output wire VS,
  output wire BLANK,
  output wire VGA_SYNC,
  output wire VGA_CLK,
  output wire [9:0] h_pos,
  output wire [9:0] v_pos,
  output wire [19:0] oAddress
);

  // Instância do módulo ImageMerge
  ImageMerge im (
    .sdram_R(sdram_R),
    .sdram_G(sdram_G),
    .sdram_B(sdram_B),
    .sprite_R(sprite_R),
    .sprite_G(sprite_G),
    .sprite_B(sprite_B),
    .alpha(sprite_valid ? 255 : 0), // Defina alpha para 255 (opaco) quando o sprite for válido, caso contrário, 0 (transparente)
    .merged_R(R_in), // A saída do ImageMerge é conectada às entradas do VGA_Interface
    .merged_G(G_in),
    .merged_B(B_in)
  );

  // Instância do módulo VGA_Interface
  VGA_Interface vga (
    .R_in(R),
    .G_in(G),
    .B_in(B),
    .clk(clk),
    .rst(rst),
    .R(R_in), // Conecta as saídas do ImageMerge às entradas do VGA_Interface
    .G(G_in),
    .B(B_in),
    .HS(HS),
    .VS(VS),
    .BLANK(BLANK),
    .VGA_SYNC(VGA_SYNC),
    .VGA_CLK(VGA_CLK),
    .h_pos(h_pos),
    .v_pos(v_pos),
    .oAddress(oAddress)
  );

endmodule
