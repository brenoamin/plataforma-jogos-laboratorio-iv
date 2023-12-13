//! @title Registrador de Execução
//! @author @brenoamin

//! O Registrador de Execução é um componente que armazena os dados, instruções e flags de status
//! após a etapa de execução em um processador pipeline.
//! Este módulo Verilog representa um registrador de execução parametrizável.

module execute #(
    parameter DWIDTH = 32 //! Largura dos dados armazenados
  )(
    input wire clk, //! Sinal de clock
    input wire rst, //! Sinal de reset
    input wire full_stack, empty_stack, //! flags da pilha
    input wire [DWIDTH-1:0] data,  //! Dados de entrada
    input wire [DWIDTH-1:0] instr, //! Instrução de entrada
    input wire [DWIDTH-1:0] register, //! Dados do registrador de entrada
    input wire [DWIDTH-1:0] mux_register, //! Dados do registrador do multiplexador de entrada
    //input wire overflow, //! Flag de overflow
    input wire equal,  //! Flag de igualdade
    input wire above,  //! Flag de acima
    input wire below, //! Flag de abaixo
    //input wire between, //! Flag de entre
    //input wire collision,  //! Flag de colisão
    input wire error, //! Flag de erro


    output reg [DWIDTH-1:0] stored_data, //! Dados armazenados
    output reg [DWIDTH-1:0] stored_instr,  //! Instrução armazenada
    output reg [DWIDTH-1:0] stored_register, //! Dados do registrador armazenados
    output reg [DWIDTH-1:0] r_abs, //! Dados absolutos do registrador
    output reg [4:0] RFlags,   //! Flags de status
    output reg reset_regs     //! Flag de reset dos registradores
  );

  //! Lógica para armazenar dados, instruções e flags de status
  always @(posedge clk or posedge rst)
  begin : EXECUTE
    if (rst)
    begin
      stored_data     <= 0;
      stored_instr    <= 0;
      stored_register <= 0;
      r_abs           <= 0;
      RFlags          <= 0;
      reset_regs      <= 0;
    end
    else
    begin
		stored_register <= register;
      stored_data  <= data;
      stored_instr <= instr;
      RFlags[0]    <= full_stack;
      RFlags[1]    <= above;
      RFlags[2]    <= equal;
      RFlags[3]    <= below;
      //RFlags[]    <= between;
      //RFlags[]    <= collision;
      RFlags[4]    <= error || empty_stack;
      r_abs        <= instr[31:27] == 13 || instr[31:27] == 14 || instr[31:27] == 15 || instr[31:27] == 16 || instr[31:27] == 17 ? mux_register : 32'bz;
      reset_regs   <= instr[31:27] == 13 || instr[31:27] == 14 || instr[31:27] == 15 || instr[31:27] == 16 || instr[31:27] == 17 ? 1'b1 : 1'b0;
    end
  end
endmodule
