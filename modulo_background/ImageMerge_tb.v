module ImageMerge_tb;

reg clk = 0;
always #1 clk = ~clk;

reg [7:0] sdram_R;
reg [7:0] sdram_G;
reg [7:0] sdram_B;
reg [7:0] sprite_R;
reg [7:0] sprite_G;
reg [7:0] sprite_B;
reg [7:0] alpha;
wire [7:0] merged_R;
wire [7:0] merged_G;
wire [7:0] merged_B;

ImageMerge im (
  .sdram_R(sdram_R),
  .sdram_G(sdram_G),
  .sdram_B(sdram_B),
  .sprite_R(sprite_R),
  .sprite_G(sprite_G),
  .sprite_B(sprite_B),
  .alpha(alpha),
  .merged_R(merged_R),
  .merged_G(merged_G),
  .merged_B(merged_B)
);

initial begin
// Teste 1: SDRAM totalmente visível, alpha máximo (255)
sdram_R = 255; sdram_G = 0; sdram_B = 0;
sprite_R = 0; sprite_G = 255; sprite_B = 0;
alpha = 255;
#1;
if (merged_R !== 255 || merged_G !== 0 || merged_B !== 0)
  $display("Teste 1 falhou.");

// Teste 2: Sprite totalmente visível, alpha mínimo (0)
sdram_R = 0; sdram_G = 255; sdram_B = 0;
sprite_R = 255; sprite_G = 0; sprite_B = 0;
alpha = 0;
#1;
if (merged_R !== 255 || merged_G !== 255 || merged_B !== 0)
  $display("Teste 2 falhou.");

// Teste 3: Combinação com alpha parcial (128)
sdram_R = 255; sdram_G = 0; sdram_B = 0;
sprite_R = 0; sprite_G = 255; sprite_B = 0;
alpha = 128;
#1;
if (merged_R !== 128 || merged_G !== 128 || merged_B !== 0)
  $display("Teste 3 falhou.");


  $stop;
end

endmodule
