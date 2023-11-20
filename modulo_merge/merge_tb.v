`timescale 1ns/1ns // Definindo a escala de tempo para simulação

module testbench;

  // Definindo parâmetros
  reg clk, reset, readVgaSelector;
  reg [7:0] R_bg, G_bg, B_bg, R_sp, G_sp, B_sp;
  reg [9:0] posX_bg, posY_bg, posX_sp, posY_sp;
  wire [127:0] R_outRegA, G_outRegA, B_outRegA, R_outRegB, G_outRegB, B_outRegB;
  wire [3:0] collision;

  // Instanciando o módulo a ser testado
  merge uut (
    .clk(clk),
    .reset(reset),
    .readVgaSelector(readVgaSelector),
    .R_bg(R_bg),
    .G_bg(G_bg),
    .B_bg(B_bg),
    .R_sp(R_sp),
    .G_sp(G_sp),
    .B_sp(B_sp),
    .R_outRegA(R_outRegA),
    .G_outRegA(G_outRegA),
    .B_outRegA(B_outRegA),
    .R_outRegB(R_outRegB),
    .G_outRegB(G_outRegB),
    .B_outRegB(B_outRegB),
    .posX_bg(posX_bg),
    .posY_bg(posY_bg),
    .posX_sp(posX_sp),
    .posY_sp(posY_sp),
    .collision(collision)
  );


    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end


    initial begin
    reset = 1'b1;
        #2;
    reset = 1'b0;
    readVgaSelector = 1'b1;

    end

    initial 
        begin
            //A cada pulso de clock preenche os registradores A
            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;


            //Seleciona o registrador A como leitura
            #;
            readVgaSelector = 1'b0;
            #5;


            //A cada pulso de clock preenche os registradores B
            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b0111110100;//500
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b0111110100;//500

            R_sp = 8'h87;
            G_sp = 8'h32;
            B_sp = 8'h50;
            posX_sp = 10'b0000000001;
            posY_sp = 10'b1111011110;//990

            #1;
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 10'b1111011110;//990
            posY_bg = 10'b1111011110;//990

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 10'b1111011110;//990
            posY_sp = 10'b0000000001;


            #1;
            reset = 1'b0;

        end

endmodule