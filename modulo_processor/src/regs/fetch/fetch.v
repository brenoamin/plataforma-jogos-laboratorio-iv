//! @title Pipeline Register: Fetch
//! @author taffarel55

//! Este módulo representa o registrador de pipeline fetch.
//! O registrador fetch fica após a Memória de Programa e
//! armazena temporariamente o endereço e a instrução lida
//! da Memória de Programa antes de fornecê-los ao próximo
//! estágio do pipeline.

module fetch #(
  parameter AWIDTH = 15, //! Tamanho do barramento de endereços
  parameter DWIDTH = 32 //! Tamanho da palavra de instrução em bits
) (
  input wire clk, rst,                     //! Entradas: Sinal de clock e reset
  input wire [AWIDTH-1:0] fetch_addr,      //! Entrada: Endereço de leitura da Memória de Programa
  input wire [DWIDTH-1:0] fetch_instr,     //! Entrada: Instrução lida da Memória de Programa
  output reg [AWIDTH-1:0] fetched_addr,    //! Saída: Endereço fornecido ao próximo estágio
  output reg [DWIDTH-1:0] fetched_instr    //! Saída: Instrução fornecida ao próximo estágio
);

always @(posedge clk, posedge rst)
begin : FETCH
  if (rst)
  begin
    fetched_addr <= 0;
    fetched_instr <= 0;
  end
  else
  begin
    fetched_addr <= fetch_addr;
    fetched_instr <= fetch_instr;
  end
end
endmodule
