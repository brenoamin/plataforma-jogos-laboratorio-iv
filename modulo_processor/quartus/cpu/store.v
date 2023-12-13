
//! @title Registrador de Pipeline
//! @author @brenuamin

//! O Registrador de Pipeline - Store. Localizado entre a saída da memória de dados e a etapa de Write Back.
//! Armazena temporariamente dados e instruções propagadas ao longo do pipeline.

module store #(
    parameter DWIDTH = 32 //! Largura dos dados, memória de dados e instruções armazenados
  )(
    input wire clk, //! Sinal de clock para operações assíncronas
    input wire rst, //! Sinal de reset para redefinir os registradores
    input wire [DWIDTH-1:0] data, //! Dados a serem armazenados
    input wire [DWIDTH-1:0] mem_data, //! Dados da memória de dados a serem armazenados
    input wire [DWIDTH-1:0] instr, //! Instrução a ser armazenada

    output reg [DWIDTH-1:0] stored_data,    //! Dados armazenados
    output reg [DWIDTH-1:0] stored_mem_data,//! Dados da memória de dados armazenados
    output reg [DWIDTH-1:0] stored_instr    //! Instrução armazenada
  );

  //! Lógica para atualização do registrador de pipeline a partir do clock
  always @(posedge clk or posedge rst)
  begin : STORE
    if (rst)
    begin
      stored_data <= 0;
      stored_mem_data <= 0;
      stored_instr <= 0;
    end
    else
    begin
      stored_data <= data;
      stored_mem_data <= mem_data;
      stored_instr <= instr;
    end
  end
endmodule
