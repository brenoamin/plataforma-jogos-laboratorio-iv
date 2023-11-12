module merge (R_bg, G_bg, B_bg, R_sp, G_sp, B_sp, R_out, G_out, B_out, posX_bg, posY_bg, posX_sp, posY_sp, colision, reset, clk);

    input wire clk, reset;
    input wire [7:0] R_bg, G_bg, B_bg, R_sp, G_sp, B_sp
    input wire [1:0] positionBackground, positionSprite;
    output reg [7:0] R_out, G_out, B_out;
    output reg [1:0]; 

    //Size sprite = 16un
    //Position X e Y do background e do sprits
    // Entrada size vinda do processador com o tamanho X e Y da imagem
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
    end
    
endmodule