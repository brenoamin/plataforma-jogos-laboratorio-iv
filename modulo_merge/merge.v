module merge (R_bg, G_bg, B_bg, R_sp, G_sp, B_sp, R_out, G_out, B_out, posX_bg, posY_bg, posX_sp, posY_sp, sprite_collision_BG, reset, clk);

    input wire clk, reset;
    input wire [7:0] R_bg, G_bg, B_bg, R_sp, G_sp, B_sp
    input wire [9:0] posX_bg, posY_bg, posX_sp, posY_sp;
    output reg [7:0] R_out, G_out, B_out;
    output reg [1:0]; 
    output reg colision;

    localparam SPRITE_SIZE = 16;
    localparam BG_SIZE_X = 1000;
    localparam BG_SIZE_Y = 1000;
    localparam  = R_trans = 8'h17
                  G_trans = 8'h17
                  B_trans = 8'h17;

    always@(posedge clk) 
    begin
        if (reset)
        begin
            R_out <= 8'h00;
            G_out <= 8'h00;
            B_out <= 8'h00;
            sprite_collision_BG <= 1'b0;
        end
        else
        begin
            if (R_sp == R_trans && G_sp == G_trans && B_sp == B_trans) //Verifica se a entrada do sprit é a cor transparente naquele pixel
            begin
                R_out <= R_bg;
                G_out <= G_bg;
                B_out <= B_bg;
            end
            else
            begin
                R_out <= R_sp;
                G_out <= G_sp;
                B_out <= B_sp;
            end          
        end

        if (posX_sp + SPRITE_SIZE >= BG_SIZE_X)
        begin
            colision <= 4'b0001; // Colisão à direita
        end
        else if (posX_sp <= 0)
        begin
            colision <= 4'b0010; // Colisão à esquerda
        end
        else if (posY_sp + SPRITE_SIZE >= BG_SIZE_Y)
        begin
            colision <= 4'b0100; // Colisão em baixo
        end
        else if (posY_sp <= 0)
        begin
            colision <= 4'b1000; // Colisão em cima
        end
        else
        begin
            colision <= 4'b0000; // Sem colisão
        end
    end
endmodule