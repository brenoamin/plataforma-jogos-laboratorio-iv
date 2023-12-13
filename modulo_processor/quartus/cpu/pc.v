//! @title PC
//! @author taffarel55

//! Um Contador de Programa (PC) é um componente essencial
//! de uma Unidade Central de Processamento (CPU) que é
//! responsável por armazenar o endereço da próxima instrução
//! a ser executada em um programa. Este módulo Verilog
//! implementa um PC com entrada para o clock, sinal de reset,
//! instrução de entrada e seleção de operação, e uma saída
//! para o endereço da próxima instrução.

module pc #(
    parameter WORD_SIZE = 32, //! Tamanho da palavra de instrução em bits
    parameter ADDR_SIZE = 15,  //! Tamanho do barramento de endereços
	  parameter OPT_SIZE = 1  //! Tamanho do seletor em bits
  ) (
    input wire clk,                     //! Entrada de clock
    input wire rst,                     //! Entrada reset síncrono
    input wire [WORD_SIZE-1:0]  instr,  //! Entrada de instrução
    input wire sel,    //! Seletor
    output reg [ADDR_SIZE-1:0]  out     //! Saída do PC
  );
   
  localparam NEXT_INSTR = 0;    //! Estado NEXT_INSTR
  //localparam KEEP_INSTR = 1;    //! Estado KEEP_INSTR
  localparam LOAD_INSTR = 1;    //! Estado LOAD_INSTR

  always @(posedge clk)
  begin : PC
    if (rst==1'b1)
      out <= 0;
    else
    begin
      case(sel)
        NEXT_INSTR:
          out <= out + 1;
        LOAD_INSTR:
          out <= instr;
        default:
          out <= out;
      endcase
    end
  end

endmodule

// iverilog -t null *.v
