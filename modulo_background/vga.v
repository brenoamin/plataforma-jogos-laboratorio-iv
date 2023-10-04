module vga (
  input clk,                   // Sinal de clock de entrada
  input [9:0] IMAGE_OFFSET_X,  // Posição horizontal da imagem
  input [9:0] IMAGE_OFFSET_Y,  // Posição vertical da imagem
  output reg vga_h_sync,       // Sinal de sincronização horizontal
  output reg vga_v_sync,       // Sinal de sincronização vertical
  output reg inDisplayArea = 0, // Sinal indicando se está dentro da área de exibição
  output reg [9:0] CounterX = 0, // Contador de posição horizontal
  output reg [9:0] CounterY = 0  // Contador de posição vertical
);

  // Definição dos parâmetros de tamanho da imagem
  parameter IMAGE_WIDTH = 640;
  parameter IMAGE_HEIGHT = 480;

  // Declaração de registradores e fios
  reg [9:0] clockCounter = 0;
  wire CounterXmaxed = (CounterX == 767); // Verifica se o contador X atingiu o máximo
  wire CounterYmaxed = (CounterY == 511); // Verifica se o contador Y atingiu o máximo

  localparam [9:0] min_x = 64; // Posição mínima em X
  localparam [9:0] min_y = 16; // Posição mínima em Y
  localparam [9:0] max_x = IMAGE_WIDTH + min_x - 1; // Posição máxima em X
  localparam [9:0] max_y = IMAGE_HEIGHT + min_y - 1; // Posição máxima em Y

  always @(posedge clk) begin
    clockCounter <= clockCounter + 1; // Contagem dos pulsos de clock
  end

  always @(clockCounter) begin
    // Lógica para atualizar os contadores de posição X e Y
    CounterX <= (CounterXmaxed) ? IMAGE_OFFSET_X : CounterX + 1;
    CounterY <= (CounterYmaxed) ? IMAGE_OFFSET_Y : (CounterXmaxed) ? CounterY + 1 : CounterY;
    inDisplayArea <= (CounterYmaxed) ? 0 : (CounterXmaxed) ? 0 : 
                    (CounterX >= min_x - 1 && CounterX <= max_x - 1) && 
                    (CounterY >= min_y && CounterY <= max_y);
  end

  always @(posedge clk) begin
    // Lógica para controlar os sinais de sincronização horizontal e vertical
    vga_h_sync <= (CounterX == IMAGE_OFFSET_X); // Verifica se deve ocorrer uma sincronização horizontal
    vga_v_sync <= (CounterX == IMAGE_OFFSET_X && CounterY == IMAGE_OFFSET_Y); // Verifica se deve ocorrer uma sincronização vertical
  end

endmodule
