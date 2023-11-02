//! @title Memória de Programa
//! @author @brenoamin

//! A Memória de Programa é um componente que armazena as instruções de um programa
//! e permite a leitura e escrita de dados com base em endereços de memória.
//! Este módulo Verilog representa uma memória de programa parametrizável.

module memory #(
    parameter integer AWIDTH = 15,  //! Largura do endereço da memória
    parameter integer DWIDTH = 32   //! Largura dos dados armazenados
  )(
    input wire [AWIDTH-1:0] addr,    //! Entrada de endereço de memória
    input wire wr, rd,              //! Sinais de escrita (wr) e leitura (rd)
    input wire [DWIDTH-1:0] data_in, //! Dados de entrada para escrita
    output wire [DWIDTH-1:0] data_out //! Dados lidos da memória
  );
  
    reg [DWIDTH-1:0] memory [2**AWIDTH-1:0]; //! Memória de programa parametrizável
    reg [DWIDTH-1:0] rdata;                   //! Dados lidos da memória
  
    //! Lógica para determinar a saída de dados da memória
    assign data_out = rd ? rdata : {DWIDTH{1'bz}};
  
    //! Lógica para escrita e leitura de dados na memória
    always @(wr, rd)
    begin : MEMORY_ACCESS
      if (wr)
        memory[addr] = data_in;
      else if (rd)
        rdata = memory[addr];
    end
  endmodule
  