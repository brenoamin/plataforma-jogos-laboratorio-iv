//! @title Registrador de Decode
//! @author @LeandroGama

module decode #(
    parameter DWIDTH = 32,                  //! Largura dos dados armazenados
	 parameter AWIDTH = 15                   //! Largura dos endereços de memória
  )(
    input wire clk,                         //! Sinal de clock
    input wire rst,                         //! Sinal de reset
    input wire [AWIDTH-1:0] addr,           //! Endereço de leitura da Memória de Programa
    input wire [DWIDTH-1:0] immed,          //! Imediato
    input wire [DWIDTH-1:0] inst,           //! Instrução de entrada
    input wire [DWIDTH-1:0] Rd1,            //! Registrador d1
    input wire [DWIDTH-1:0] Rd2,            //! Registrador d2

    output reg [AWIDTH-1:0] stored_addr,    //! Endereço de leitura da Memória de Programa fornecido ao próximo estágio
    output reg [DWIDTH-1:0] stored_immed,   //! Imediato fornecido ao próximo estágio
    output reg [DWIDTH-1:0] stored_inst,    //! Instrução fornecida ao próximo estágio
    output reg [DWIDTH-1:0] stored_Rd1,     //! Registrador d1 fornecida ao próximo estágio
    output reg [DWIDTH-1:0] stored_Rd2     //! Registrador d2 fornecida ao próximo estágio

  );

  //! Lógica para armazenar dados, instruções e flags de status
    always @(posedge clk or posedge rst)
    begin : Decode
        if (rst) begin
            stored_addr   <= 0;
            stored_immed  <= 0;
            stored_inst   <= 0;
            stored_Rd1    <= 0;
            stored_Rd2    <= 0;
        end
        else begin
            stored_addr  <= addr;
            stored_immed <= immed;
            stored_inst  <= inst;
            stored_Rd1   <= Rd1;
            stored_Rd2   <= Rd2;
        end
    end
endmodule