`timescale 1ns/1ns

module merge_tb;

    // Sinais de clock e reset
    reg clk;
    reg reset;

    // Sinais de entrada
    reg [7:0] R_bg, G_bg, B_bg, R_sp, G_sp, B_sp;
    reg [9:0] posX_bg, posY_bg, posX_sp, posY_sp;

    // Sinais de saída
    wire [7:0] R_out, G_out, B_out;
    wire [3:0] collision;

    // Instanciação do módulo a ser testado
    merge uut (
        .clk(clk),
        .reset(reset),
        .R_bg(R_bg),
        .G_bg(G_bg),
        .B_bg(B_bg),
        .R_sp(R_sp),
        .G_sp(G_sp),
        .B_sp(B_sp),
        .R_out(R_out),
        .G_out(G_out),
        .B_out(B_out),
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
        #10;
    reset = 1'b0;
    end

    initial 
        begin
            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 600;
            posY_bg = 500;

            R_sp = 8'h17;
            G_sp = 8'h17;
            B_sp = 8'h17;

            posX_sp = 1;
            posY_sp = 1;

            #20;

            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 600;
            posY_bg = 500;

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = ;
            posY_sp = 1;

            #20;

            R_bg = 8'h20;
            G_bg = 8'h50;
            B_bg = 8'h40;
            posX_bg = 990;
            posY_bg = 500;

            R_sp = 8'h30;
            G_sp = 8'h54;
            B_sp = 8'h41;
            posX_sp = 1;
            posY_sp = 1;
        end

endmodule