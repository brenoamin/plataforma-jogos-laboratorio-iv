module data_bus(
  input wire clk,                  // Sinal de clock
  input wire [7:0] pixel_R,        // Componente vermelho do pixel
  input wire [7:0] pixel_G,        // Componente verde do pixel
  input wire [7:0] pixel_B,        // Componente azul do pixel
  output wire [23:0] vga_data,     // Barramento de dados para o VGA (24 bits)
  output wire vga_h_sync,          // Sinal de sincronização horizontal para o VGA
  output wire vga_v_sync           // Sinal de sincronização vertical para o VGA
);

  // Sinais de sincronização gerados pelo VGA (assumindo que já existem)
  // Certifique-se de que esses sinais estejam sincronizados com o sinal de clock.

  // Conecte os componentes de cor RGB ao barramento de dados VGA.
  assign vga_data = {pixel_R, pixel_G, pixel_B};

  // Passe os sinais de sincronização do VGA diretamente para o módulo VGA.
  assign vga_h_sync = ...; // Conecte ao sinal de sincronização horizontal do VGA
  assign vga_v_sync = ...; // Conecte ao sinal de sincronização vertical do VGA

endmodule
