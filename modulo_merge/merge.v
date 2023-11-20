module merge (R_bg, G_bg, B_bg, R_sp, G_sp, B_sp, R_outRegA, G_outRegA, B_outRegA, R_outRegB, G_outRegB, B_outRegB, posX_bg, posY_bg, posX_sp, posY_sp, collision, reset, clk);

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

	

    // Quando o VGA começar a ler o registrado A, zera o B. Assim como, quando começa a ler o B, zera o A
    always @(posedge readVgaSelector)
    begin
        R_outRegA <= 0;
        G_outRegA <= 0;
        B_outRegA <= 0;
    end

    always @(negedge readVgaSelector)
    begin
        R_outRegB <= 0;
        G_outRegB <= 0;
        B_outRegB <= 0;
    end


    always@(posedge clk) 
    begin
        if (reset)
        begin
            R_outRegA <= 0;
            G_outRegA <= 0;
            B_outRegA <= 0;
            R_outRegB <= 0;
            G_outRegB <= 0;
            B_outRegB <= 0;
            
            collision <= 1'b0;
        end
        else
        begin

            if (readVgaSelector) //Se o VGA está lendo o registrador tipo B prepara os pixels do registrador A,
            begin
                if (R_sp == R_trans && G_sp == G_trans && B_sp == B_trans) //Verifica se a entrada do sprit é a cor transparente naquele pixel, se for preenche com o background
                begin 
                    R_outRegA <= {R_outRegA, R_bg};
                    G_outRegA <= {G_outRegA, G_bg};
                    B_outRegA <= {B_outRegA, B_bg};
                end
                else begin
                    R_outRegA <= {R_outRegA, R_sp};
                    G_outRegA <= {G_outRegA, G_sp};
                    B_outRegA <= {B_outRegA, B_sp};
                end
            end else
                if (R_sp == R_trans && G_sp == G_trans && B_sp == B_trans) //Verifica se a entrada do sprit é a cor transparente naquele pixel, se for preenche com o background
                begin 
                    R_outRegB <= {R_outRegB, R_bg};
                    G_outRegB <= {G_outRegB, G_bg};
                    B_outRegB <= {B_outRegB, B_bg};
                end
                else begin
                    R_outRegB <= {R_outRegB, R_sp};
                    G_outRegB <= {G_outRegB, G_sp};
                    B_outRegB <= {B_outRegB, B_sp};
                end
         
        

            if (posX_sp + SPRITE_SIZE >= BG_SIZE_X)
            begin
                collision <= 4'b0001; // Colisão à direita
            end
            else if (posX_sp <= 0)
            begin
                collision <= 4'b0010; // Colisão à esquerda
            end
            else if (posY_sp + SPRITE_SIZE >= BG_SIZE_Y)
            begin
                collision <= 4'b0100; // Colisão em baixo
            end
            else if (posY_sp <= 0)
            begin
                collision <= 4'b1000; // Colisão em cima
            end
            else
            begin
                collision <= 4'b0000; // Sem colisão
            end
        end
    end


endmodule