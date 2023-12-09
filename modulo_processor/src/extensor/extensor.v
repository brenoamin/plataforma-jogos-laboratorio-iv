//! @title Extensor de Bits
//! @author brenoamin, taffarel55

//! Um extensor de bits é um componente que expande o tamanho
//! de um valor imediato de acordo com o tipo de instrução.
//! Este módulo Verilog aceita uma instrução de 32 bits
//! e gera um valor imediato de 32 bits como saída.

// Instruções
// DATA TRANSFER
//! {reg: [
//!   { name: "Rb, Rs", bits: 5 ,  attr: "Endereço Origem"	, type: 4 },
//!   { name: ""      , bits: 1 ,  attr: ""					        , type: 0 },
//!   { name: "IMED"  , bits: 16,  attr: "Imediato"			    , type: 3 },
//!   { name: "Rd, Rs", bits: 5 ,  attr: "Endereço Destino"	, type: 2 },
//!   { name: "INSTR" , bits: 5 ,  attr: "Instrução"			  , type: 1 },
//! ]}
// LOGICAL and ARITHMETIC
//! {reg: [
//!   { name: "IMED" 	, bits: 12 ,  attr: "Imediato"			    , type: 3 },
//!   { name: "Rs1"	  , bits: 5	 ,  attr: "Operando 2"		    , type: 4 },
//!   { name: "Rs1"	  , bits: 5	 ,  attr: "Operando 1"		    , type: 4 },
//!   { name: "Rd"	  , bits: 5  ,  attr: "Endereço Destino"	, type: 2 },
//!   { name: "INSTR"	, bits: 5  ,  attr: "Instrução"		      , type: 1 },
//! ]}
// CONTROL TRANSFER 1
//! {reg: [
//! { name: "M" 	  , bits: 7  , attr: "Máscara para comparação" , type: 4 },
//! { name: "I" 	  , bits: 7  , attr: "Vetor para comparação"	 , type: 3 },
//! { name: "R" 	  , bits: 13 , attr: "Endereço"				         , type: 2 },
//! { name: "INSTR"	, bits: 5  , attr: "Instrução"				       , type: 1 },
//! ]}
// CONTROL TRANSFER 2
//! {reg: [
//!   { name: "IM" 	  , bits: 27 , attr: "Imediato"  , type: 3 },
//!   { name: "INSTR"	, bits: 5  , attr: "Instrução" , type: 1 },
//! ]}

// TODO: PARAMETRIZAR TAMANHO
module extensor(
    input wire [31:0] instruction,  //! Entrada da instrução de 32 bits
    output reg [31:0] immediate     //! Saída do valor imediato de 32 bits
  );

  localparam DATA_TRANSFER          = 5'b00000; //! Tipo de instrução: Transferência de Dados
  localparam ARITHMETIC_AND_LOGICAL = 5'b00001; //! Tipo de instrução: Operações Aritméticas e Lógicas
  localparam CONTROL_TRANSFER       = 5'b00010; //! Tipo de instrução: Transferência de Controle

  reg [1:0] instruction_type;   //! Tipo de instrução extraído da instrução de entrada;

  wire [15:0] immediate_dt;     //! Imediato para instruções de Transferência de Dados
  wire [11:0] immediate_al;     //! Imediato para instruções Aritméticas e Lógicas
  wire [26:0] immediate_ct;     //! Imediato para instruções de Transferência de Controle

  assign immediate_dt = instruction[21:6];
  assign immediate_al = instruction[11:0];
  assign immediate_ct = instruction[26:0];

  //! Lógica para determinar o valor imediato baseado no tipo de instrução
  always @(*)
  begin : EXT32
    case (instruction_type)
      DATA_TRANSFER:
      begin
        $display("caiu na 1 ");
        immediate = {{16{immediate_dt[15]}}, immediate_dt};
      end

      ARITHMETIC_AND_LOGICAL:
      begin
        $display("caiu na 2 ");
        immediate = {{20{immediate_al[11]}}, immediate_al};
      end

      CONTROL_TRANSFER:
      begin
        $display("caiu na 3 ");
        immediate = {{5{immediate_ct[26]}}, immediate_ct};
      end
      default:
        immediate = instruction;
    endcase
  end

  // TODO: Colocar parâmetros de instruções, ser específico quais instruções precisam de imediato
  //! Extração do tipo de instrução
  always @(*)
  begin : get_instruction_type
    case(instruction[31:27])
      0,1,2:
        instruction_type = DATA_TRANSFER;
      3,4,5,6,7,8,9,10,11,12:
        instruction_type = ARITHMETIC_AND_LOGICAL;
      13,14,15,16,17,18:
        instruction_type = CONTROL_TRANSFER;
      default:
        instruction_type = 0;
    endcase
  end
endmodule
