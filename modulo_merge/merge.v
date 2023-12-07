module merge (R_bg, G_bg, B_bg, R_sp, G_sp, B_sp, R_outRegA, G_outRegA, B_outRegA, R_outRegB, G_outRegB, B_outRegB, posX_bg, posY_bg, posX_sp, posY_sp, collision, reset, clk, readVgaSelector);

    input wire clk, reset, readVgaSelector;
    input wire [7:0] R_bg, G_bg, B_bg, R_sp, G_sp, B_sp;
    input wire [9:0] posX_bg, posY_bg, posX_sp, posY_sp;
    output reg [127:0] R_outRegA, G_outRegA, B_outRegA, R_outRegB, G_outRegB, B_outRegB;
    output reg [3:0] collision;

    localparam SPRITE_SIZE = 16;
    localparam BG_SIZE_X = 1000;
    localparam BG_SIZE_Y = 1000;
    localparam R_trans = 8'h17,
               G_trans = 8'h17,
               B_trans = 8'h17;

	reg [3:0] contadorA = 4'b0;
	reg [6:0] base_indexA = 7'b0;
	
    reg [3:0] contadorB = 4'b0;
	reg [6:0] base_indexB = 7'b0;

    reg full_A = 1'b0;
    reg full_B = 1'b0;


    always@(posedge clk) 
    begin
        if (reset)
        begin
            R_outRegA <= 128'b0;
            G_outRegA <= 128'b0;
            B_outRegA <= 128'b0;
            R_outRegB <= 128'b0;
            G_outRegB <= 128'b0;
            B_outRegB <= 128'b0;
            contadorA  <= 4'b0;
			contadorB  <= 4'b0;
			full_A <= 1'b0;
			full_B <= 1'b0;
            collision <= 1'b0;
        end
        else
        begin

            base_indexA = contadorA * 8;
            base_indexB = contadorB * 8;

            if (readVgaSelector == 1'b1 && !full_A) //Se o VGA estÃ¡ lendo o registrador tipo B prepara os pixels do registrador A,
            begin
                full_B <= 1'b0; //ComeÃ§a a ler o registrador A, volta o estado de full_A para 0.

                if (R_sp == R_trans && G_sp == G_trans && B_sp == B_trans) //Verifica se a entrada do sprit Ã© a cor transparente naquele pixel, se for preenche com o background
                begin 
                    R_outRegA[base_indexA +: 8] <= R_bg;
                    G_outRegA[base_indexA +: 8] <= G_bg;
                    B_outRegA[base_indexA +: 8] <= B_bg;
                end
                else begin
                    R_outRegA[base_indexA +: 8] <= R_sp;
                    G_outRegA[base_indexA +: 8] <= G_sp;
                    B_outRegA[base_indexA +: 8] <= B_sp;
                end

                contadorA <= contadorA + 1;

            end else if (readVgaSelector == 1'b0 && !full_B) begin

                full_A <= 1'b0; //ComeÃ§a a ler o registrador A, volta o estado de full_A para 0.

                if (R_sp == R_trans && G_sp == G_trans && B_sp == B_trans) //Verifica se a entrada do sprit Ã© a cor transparente naquele pixel, se for preenche com o background
                begin 
                    R_outRegB[base_indexB +: 8] <= R_bg;
                    G_outRegB[base_indexB +: 8] <= G_bg;
                    B_outRegB[base_indexB +: 8] <= B_bg;
                end
                else begin
                    R_outRegB[base_indexB +: 8] <= R_sp;
                    G_outRegB[base_indexB +: 8] <= G_sp;
                    B_outRegB[base_indexB +: 8] <= B_sp;
                end
				
				contadorB <= contadorB + 1;
                
            end

            if (contadorA == 15) begin // Reinicia o contador apÃ³s o Ãºltimo conjunto de 8 bits (16 * 8 = 128 bits)
                full_A <= 1'b1;
                contadorA <= 4'b0;   
                end

            if (contadorB == 15) begin // Reinicia o contador apÃ³s o Ãºltimo conjunto de 8 bits (16 * 8 = 128 bits)
                contadorB <= 4'b0;
                full_B <= 1'b1;
                end

            if (posX_sp + SPRITE_SIZE >= BG_SIZE_X)
            begin
                collision <= 4'b0001; // ColisÃ£o Ã  direita
            end
            else if (posX_sp <= 0)
            begin
                collision <= 4'b0010; // ColisÃ£o Ã  esquerda
            end
            else if (posY_sp + SPRITE_SIZE >= BG_SIZE_Y)
            begin
                collision <= 4'b0100; // ColisÃ£o em baixo
            end
            else if (posY_sp <= 0)
            begin
                collision <= 4'b1000; // ColisÃ£o em cima
            end
            else
            begin
                collision <= 4'b0000; // Sem colisÃ£o
            end
        end
    end


endmodule