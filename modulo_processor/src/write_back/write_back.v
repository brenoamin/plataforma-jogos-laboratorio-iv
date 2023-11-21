//! @title MUX: Write Back
//! @author brenoamin


//! Este módulo representa um Multiplexador (MUX) utilizado na etapa de Write Back de um pipeline. 
//! Ele seleciona os dados de saída apropriados com base no tipo de instrução recebida.
//! O MUX considera a instrução de 32 bits, dados de entrada e dados da memória como entradas e 
//! gera dados de saída correspondentes ao tipo de instrução recebida. As instruções 
//! são identificadas pelos bits mais significativos da instrução, determinando o tipo de operação 
//! a ser realizada. Os dados de saída do MUX são utilizados na etapa final do pipeline, 
//! influenciando o comportamento do processador.

module write_back (
    input wire [31:0] instruction,        //! Entrada: Instrução de 32 bits
    input wire [31:0] data_input,         //! Entrada: Dados a serem escritos em Write Back
    input wire [31:0] mem_data_input,     //! Entrada: Dados da memória a serem escritos em Write Back
    output reg [31:0] output_data         //! Saída: Dados selecionados pelo MUX
  );

  localparam DATA_TYPE = 5'b00000;        //! Parâmetro: Tipo de instrução para outros dados
  localparam MEM_DATA_TYPE = 5'b00001;    //! Parâmetro: Tipo de instrução para dados da memória

  reg instruction_type;                   //! Registrador: Tipo de instrução atual

  // Lógica principal do MUX
  always @(*)
  begin : WRITE_BACK_MUX_LOGIC
    case (instruction_type)
      DATA_TYPE:
        output_data <= data_input;        //! Se a instrução for de outros dados, selecionar dados de entrada
      MEM_DATA_TYPE:
        output_data <= mem_data_input;    //! Se a instrução for de memória, selecionar dados da memória de entrada
      default:
        output_data <= data_input;        //! Por padrão, selecionar dados de entrada
    endcase
  end

  // Lógica para determinar o tipo de instrução
  always @(*)
  begin : DETERMINE_INSTRUCTION_TYPE
    case (instruction[31:27])
      0, 1:                                //! Instruções 0 e 1 correspondem a LW e SW
        instruction_type = MEM_DATA_TYPE;  //! Definir o tipo de instrução como memória
      2, 18:                               //! Instruções de 2 a 18 (inclusive) correspondem a todos os outros tipos de instruções
        instruction_type = DATA_TYPE;      //! Definir o tipo de instrução como outros dados
      default:
        instruction_type = DATA_TYPE;      //! Por padrão, considerar como outros dados
    endcase
  end
endmodule

