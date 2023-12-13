module VGA_Interface(
    // Entradas
    input [127:0] R_in,
    input [127:0] G_in,
    input [127:0] B_in,
    input clk, 
    input rst,

    // Saídas
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B,
    output reg HS, 
    output reg VS,
    output reg BLANK,
    output VGA_SYNC, 
    output VGA_CLK,
    output reg [9:0] h_pos, 
    output reg [9:0] v_pos,
    output reg [19:0] oAddress,
    output readVgaSelector
);

    // Parâmetros para as especificações VGA
    parameter HORIZONTAL_FRONT_PORCH = 16;
    parameter HORIZONTAL_SYNC_PULSE = 96;
    parameter HORIZONTAL_BACK_PORCH = 48;
    parameter HORIZONTAL_DISPLAY = 640;
    parameter HORIZONTAL_BLANK = HORIZONTAL_SYNC_PULSE + HORIZONTAL_BACK_PORCH;
    parameter HORIZONTAL_TOTAL = HORIZONTAL_FRONT_PORCH + HORIZONTAL_SYNC_PULSE + HORIZONTAL_BACK_PORCH + HORIZONTAL_DISPLAY;

    parameter VERTICAL_FRONT_PORCH = 10;
    parameter VERTICAL_SYNC_PULSE = 2;
    parameter VERTICAL_BACK_PORCH = 33;
    parameter VERTICAL_DISPLAY = 480;
    parameter VERTICAL_BLANK = VERTICAL_SYNC_PULSE + VERTICAL_BACK_PORCH;
    parameter VERTICAL_TOTAL = VERTICAL_FRONT_PORCH + VERTICAL_SYNC_PULSE + VERTICAL_BACK_PORCH + VERTICAL_DISPLAY;

    //Contador para ler do registrador
    reg [3:0] contador;
    reg selector = 1'b0;

    // Lógica de Controle Principal
    always @(posedge clk)
    begin
        if (rst == 1'b1)
        begin
            // Reinicializa as posições horizontal e vertical
            h_pos <= 10'b0000000000;
            v_pos <= 10'b0000000000;
        end
        else
        begin
            // Atualiza a posição horizontal, mantendo-a dentro dos limites da tela
            if (h_pos < HORIZONTAL_TOTAL - 1)
                h_pos <= h_pos + 1'b1;
            else
            begin
                h_pos <= 1'b0;
                // Atualiza a posição vertical, mantendo-a dentro dos limites da tela
                if (v_pos < VERTICAL_TOTAL - 1)
                    v_pos <= v_pos + 1'b1;
                else
                    v_pos <= 1'b0;
            end
        end
    end

    // Sincronismo Horizontal
    always @(posedge clk)
    begin
        if (rst == 1'b1)
            HS <= 1'b1;
        else
        begin
            // Durante a exibição da imagem, desativa o sinal de sincronismo horizontal
            if ((h_pos > HORIZONTAL_BACK_PORCH + HORIZONTAL_DISPLAY + HORIZONTAL_FRONT_PORCH - 1) && (h_pos < HORIZONTAL_TOTAL))
                HS <= 1'b0;
            else
                HS <= 1'b1;
        end
    end

    // Sincronismo Vertical
    always @(posedge clk)
    begin
        if (rst == 1'b1)
            VS <= 1'b1;
        else
        begin
            // Durante a exibição da imagem, desativa o sinal de sincronismo vertical
            if ((v_pos > VERTICAL_BACK_PORCH + VERTICAL_DISPLAY + VERTICAL_FRONT_PORCH - 1) && (v_pos < VERTICAL_TOTAL))
                VS <= 1'b0;
            else
                VS <= 1'b1;
        end
    end

    // Blank
    always @(posedge clk)
    begin
        if (rst == 1'b1)
            BLANK <= 1'b1;
        else
        begin
            // Durante a exibição da imagem, desativa o sinal de blank dentro dos limites
            if ((h_pos < HORIZONTAL_BACK_PORCH) || (h_pos > HORIZONTAL_BACK_PORCH + HORIZONTAL_DISPLAY - 1) || (v_pos < VERTICAL_BACK_PORCH) || (v_pos > VERTICAL_BACK_PORCH + VERTICAL_DISPLAY - 1))
                BLANK <= 1'b0;
            else
                BLANK <= 1'b1;
        end
    end

    // Atribuições
    assign VGA_CLK = clk;
    assign VGA_SYNC = 1'b0;

    assign base_indexA = contador * 8;

    always @(posedge clk)
    begin
        // Atualiza as cores R, G, e B a partir das entradas R_in, G_in, e B_in
        R <= R_in[base_indexA +: 8];
        G <= G_in[base_indexA +: 8];
        B <= B_in[base_indexA +: 8];
    end


    always @(posedge clk)
    begin
        if(rst) begin
            contador <= 0;
        end else begin
        contador <= contador + 1;
        end
    end

    always @(posedge clk) begin
        if(rst) begin
            selector <= 1'b0;
        end
        if (contador == 15)begin
            selector <= ~selector;
        end else begin
             selector <= selector;
        end
    end

    assign readVgaSelector = selector;


    // Geração de endereços na memória
    always @(posedge clk)
    begin
        // Reset no circuito, endereço vai para zero
        if (rst == 1'b1)
            oAddress <= 20'h00000;
        else
        begin
            // Operação na parte visível do vídeo
            if ((h_pos > HORIZONTAL_BACK_PORCH - 1) && (h_pos < HORIZONTAL_BACK_PORCH + HORIZONTAL_DISPLAY) && (v_pos > VERTICAL_BACK_PORCH - 1) && (v_pos < VERTICAL_BACK_PORCH + VERTICAL_DISPLAY))
            begin
                // Enquanto não tiver atingido o último pixel
                if (oAddress < ((HORIZONTAL_DISPLAY * VERTICAL_DISPLAY) - 1))
                    oAddress <= oAddress + 1'b1;
                // Retorna para o início após atingir o último pixel
                else
                    oAddress <= 1'b0;
            end
            // Operação na parte de sincronismo do vídeo
            else
                oAddress <= oAddress;
        end
    end
endmodule
