`timescale 1ns/1ps

module decode_tb;

    // Parâmetros
    parameter DWIDTH = 32;

    // Sinais de clock e reset
    reg clk;
    reg rst;

    // Sinais de entrada
    reg [DWIDTH-1:0] addr;
    reg [DWIDTH-1:0] immed;
    reg [DWIDTH-1:0] inst;
    reg [DWIDTH-1:0] Rd1;
    reg [DWIDTH-1:0] Rd2;

    // Sinais de saída
    wire [DWIDTH-1:0] stored_addr;
    wire [DWIDTH-1:0] stored_immed;
    wire [DWIDTH-1:0] stored_inst;
    wire [DWIDTH-1:0] stored_Rd1;
    wire [DWIDTH-1:0] stored_Rd2;
  wire [4:0] R;
  
    // Instância do módulo decode
    decode #(
        .DWIDTH(DWIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .immed(immed),
        .inst(inst),
        .Rd1(Rd1),
        .Rd2(Rd2),
        .stored_addr(stored_addr),
        .stored_immed(stored_immed),
        .stored_inst(stored_inst),
        .stored_Rd1(stored_Rd1),
      .stored_Rd2(stored_Rd2),
      .R(R)
    );

    // Geração de clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        addr = 0;
        immed = 0;
        inst = 0;
        Rd1 = 0;
        Rd2 = 0;

        #10;
        
        $display("Teste 1:");

        rst = 0;
        addr = 8;
        immed = 10;
        inst = 00011000110001111111000000000000;
        Rd1 = 31;
        Rd2 = 3;

        #10;

        $display("Teste 1:");
        $display("addr = %b", addr);
        $display("immed = %b", immed);
        $display("inst = %b", inst);
        $display("Rd1 = %b", Rd1);
        $display("Rd2 = %b", Rd2);
        $display("Output values:");
        $display("stored_addr = %b", stored_addr);
        $display("stored_immed = %b", stored_immed);
        $display("stored_inst = %b", stored_inst);
        $display("stored_Rd1 = %b", stored_Rd1);
        $display("stored_Rd2 = %b", stored_Rd2);

        #10;

        // Teste 2
        rst = 1;

        #10;

        $display("Teste 2:");
        $display("addr = %b", addr);
        $display("immed = %b", immed);
        $display("inst = %b", inst);
        $display("Rd1 = %b", Rd1);
        $display("Rd2 = %b", Rd2);
        $display("Output values:");
        $display("stored_addr = %b", stored_addr);
        $display("stored_immed = %b", stored_immed);
        $display("stored_inst = %b", stored_inst);
        $display("stored_Rd1 = %b", stored_Rd1);
        $display("stored_Rd2 = %b", stored_Rd2);

        #10;

        // Teste 3
        rst = 0;
        addr = 20;
        immed = 50;
        inst = 32'h00000010;
        Rd1 = 28;
        Rd2 = 10;

        #10;

        $display("Teste 3:");
        $display("addr = %b", addr);
        $display("immed = %b", immed);
        $display("inst = %b", inst);
        $display("Rd1 = %b", Rd1);
        $display("Rd2 = %b", Rd2);
        $display("Output values:");
        $display("stored_addr = %b", stored_addr);
        $display("stored_immed = %b", stored_immed);
        $display("stored_inst = %b", stored_inst);
        $display("stored_Rd1 = %b", stored_Rd1);
        $display("stored_Rd2 = %b", stored_Rd2);
      $display("R = %b", R);
        #100;

        // Teste 3
        rst = 0;
        addr = 10;
        immed = 3;
        inst = 32'b10000111001111101111110000000000;
        Rd1 = 5;
        Rd2 = 4;

        #100;

      $display("\nTeste 4:");
        $display("addr = %b", addr);
        $display("immed = %b", immed);
        $display("inst = %b", inst);
      $display("Rd1 = %d", Rd1);
      $display("Rd2 = %d", Rd2);
        $display("Output values:");
        $display("stored_addr = %b", stored_addr);
        $display("stored_immed = %b", stored_immed);
        $display("stored_inst = %b", stored_inst);
      $display("stored_Rd1 = %d", stored_Rd1);
      $display("stored_Rd2 = %d", stored_Rd2);
      	$display("R = %b", R);
      
      #10;
        $finish;
    end

endmodule
