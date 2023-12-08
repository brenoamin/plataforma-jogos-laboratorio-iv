module tb_sprits_finder_position;
  reg clk, rst, active_finder_position;
  reg [9:0] H_pos_in, V_pos_in;
  wire active_high_four;
  wire [5:0] high_four[3:0];

  // Instancie o módulo sprits_finder_position
  sprits_finder_position uut (
    .clk(clk),
    .rst(rst),
    .active_finder_position(active_finder_position),
    .H_pos_in(H_pos_in),
    .V_pos_in(V_pos_in),
    .active_high_four(active_high_four),
    .high_four(high_four)
  );

  // Adicione o código para gerar clocks, pulsos de reset e modificar as entradas durante a simulação
  // ...

  initial begin
    // Inicialize as entradas
    clk = 0;
    rst = 1;
    active_finder_position = 0;
    H_pos_in = 0;
    V_pos_in = 0;

    // Aguarde um pouco
    #10;

    // Desative o reset
    rst = 0;

    // Ative o sinal de busca de sprite
    active_finder_position = 1;

    // Modifique as coordenadas para verificar o comportamento do módulo
    H_pos_in = 10;
    V_pos_in = 5;

    // Aguarde alguns ciclos
    #100;

    // Desative o sinal de busca de sprite
    active_finder_position = 0;

    // Continue com o restante da simulação
    #100 $finish;
  end

endmodule
