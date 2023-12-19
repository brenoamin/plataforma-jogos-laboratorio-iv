module merge (R_bg, G_bg, B_bg, R_sp, G_sp, B_sp, R_outRegA, G_outRegA, B_outRegA, R_outRegB, G_outRegB, B_outRegB, posX_bg, posY_bg, posX_sp, posY_sp, reset, clk, readVgaSelector);

    input wire clk, reset, readVgaSelector;
    input wire [7:0] R_bg, G_bg, B_bg, R_sp, G_sp, B_sp;
    input wire [9:0] posX_bg, posY_bg, posX_sp, posY_sp;
    output reg [127:0] R_outRegA, G_outRegA, B_outRegA, R_outRegB, G_outRegB, B_outRegB;


    localparam R_trans = 8'h17,
               G_trans = 8'h17,
               B_trans = 8'h17;

	reg [3:0] contadorA = 4'b0;
    reg [3:0] contadorB = 4'b0;
    reg [127:0] base_indexA = 128'b0;

    reg full_A = 1'b0;
    reg full_B = 1'b0;

    assign base_indexB = contadorB * 8;

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
        end
        else
        begin

            if (readVgaSelector == 1'b1 && !full_A) //Se o VGA estÃ¡ lendo o registrador tipo B prepara os pixels do registrador A,
            begin
                full_B <= 1'b0; //ComeÃ§a a ler o registrador A, volta o estado de full_A para 0.
                base_indexA <= contadorA * 8;
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
                if (contadorA == 15) begin // Reinicia o contador apÃ³s o Ãºltimo conjunto de 8 bits (16 * 8 = 128 bits)
                    full_A <= 1'b1;
                    contadorA <= 4'b0;   
                end

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
                if (contadorB == 15) begin // Reinicia o contador apÃ³s o Ãºltimo conjunto de 8 bits (16 * 8 = 128 bits)
                    contadorB <= 4'b0;
                    full_B <= 1'b1;
                end
                
            end
      
        end
    end


endmodule