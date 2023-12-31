module VGA_Interface_tb;

    // Declare as variáveis para teste
    reg [9:0] h_pos_test;
    reg [9:0] v_pos_test;

    reg clk = 0;
    reg rst = 0;
    reg [7:0] R_in = 8'b11011011; // Exemplo de cores R, G e B
    reg [7:0] G_in = 8'b00110011;
    reg [7:0] B_in = 8'b10101010;

    wire [7:0] R;
    wire [7:0] G;
    wire [7:0] B;
    wire HS;
    wire VS;
    wire BLANK;
    wire VGA_SYNC;
    wire VGA_CLK;
    wire [9:0] h_pos;
    wire [9:0] v_pos;
    wire [19:0] oAddress;

    // Instância do módulo VGA_Interface
    VGA_Interface uut (
        .clk(clk),
        .rst(rst),
        .R_in(R_in),
        .G_in(G_in),
        .B_in(B_in),
        .R(R),
        .G(G),
        .B(B),
        .HS(HS),
        .VS(VS),
        .BLANK(BLANK),
        .VGA_SYNC(VGA_SYNC),
        .VGA_CLK(VGA_CLK),
        .h_pos(h_pos),
        .v_pos(v_pos),
        .oAddress(oAddress)
    );

    // Parâmetros para as especificações VGA
    localparam HORIZONTAL_TOTAL = 800; // Substitua pelo valor correto
    localparam VERTICAL_TOTAL = 525;   // Substitua pelo valor correto

    always #5 clk = ~clk;

    initial begin
        // Ative o reset inicialmente
        rst = 1;
        // Aguarde alguns ciclos de clock antes de desativar o reset
        #20 rst = 0;

        // Simulação de sinal de vídeo
        #100 R_in = 8'b11110000; // Exemplo de cores R, G e B diferentes
        #100 G_in = 8'b00001111;
        #100 B_in = 8'b01010101;

        // Verificação de sinais de sincronismo
        #100 if (HS != 1'b1) $display("Erro: Sinal de sincronismo horizontal desativado!");
        #100 if (VS != 1'b1) $display("Erro: Sinal de sincronismo vertical desativado!");

        // Verificação de limites de tela
        #100 if (h_pos >= HORIZONTAL_TOTAL || v_pos >= VERTICAL_TOTAL)
            $display("Erro: Posição fora dos limites da tela!");

        // Teste que ultrapassa os limites da tela
        #100 h_pos_test = HORIZONTAL_TOTAL + 1;
        #100 v_pos_test = VERTICAL_TOTAL + 1;
		  
		  // Verificação de limites de tela e impressão de mensagens
        if (h_pos_test >= HORIZONTAL_TOTAL || v_pos_test >= VERTICAL_TOTAL)
            $display("Erro: Posição fora dos limites da tela! h_pos_test=%d, v_pos_test=%d", h_pos_test, v_pos_test);


        // Mais testes e simulações aqui

        // Encerre a simulação após algum tempo
        $finish;
    end

    // Adicione aqui as verificações adicionais, conforme necessário

endmodule
