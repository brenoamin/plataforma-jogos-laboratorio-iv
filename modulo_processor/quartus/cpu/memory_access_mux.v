//! @title Memory Access Mux
//! @author @brenoamin

//! O Memory Access Mux é um componente que controla o acesso à memória em um estágio de memory access de um processador pipeline.
//! Este módulo Verilog representa um multiplexador de acesso à memória parametrizável.

module memory_access_mux #(
    parameter integer AWIDTH = 15,  //! Largura do endereço da memória
    parameter integer DWIDTH = 32   //! Largura dos dados armazenados
  )(
    input wire [DWIDTH-1:0] instr,    //! Instrução de entrada
    input wire [DWIDTH-1:0] data_ula, //! Dados de entrada da ULA
    input wire [DWIDTH-1:0] register_data, //! Dados de entrada do registrador
    output reg [DWIDTH-1:0] data_out, //! Dados de saída
    output reg [AWIDTH-1:0] addr, //! Endereço de saída
    output reg read_enable, //! Sinal de habilitação de leitura
    output reg write_enable //! Sinal de habilitação de escrita
  );


  localparam LW = 5'b00000; //! Tipo de instrução: LOAD
  localparam SW = 5'b00001; //! Tipo de instrução: STORE
  localparam BYPASS_MEMORY_ACCESS = 5'b00010; //! Tipo de instrução: OTHER THAN LOAD OR STORE


  reg [1:0] instruction_type;

  always @(*)
  begin : get_instruction_type
    case(instr[31:27])
      0:
        instruction_type = LW;
      1:
        instruction_type = SW;
      default:
        instruction_type = BYPASS_MEMORY_ACCESS;
    endcase
  end

//! Lógica para determinar a saída de dados e endereço, e os sinais de habilitação de leitura e escrita
//! com base na instrução de entrada
  always @(*)
  begin : MEMORY_ACCESS_MUX
    case (instruction_type)
      LW:
      begin
        addr          = data_ula;
        data_out      = {DWIDTH{1'bz}};
        read_enable   = 1;
        write_enable  = 0;
      end
      SW:
      begin
        addr         = data_ula;
        data_out     = register_data;
        read_enable  = 0;
        write_enable = 1;
      end
      default:
      begin
        data_out     = data_ula;
        addr         = {AWIDTH{1'bz}};
        read_enable  = 0;
        write_enable = 0;
      end
    endcase
  end
endmodule
