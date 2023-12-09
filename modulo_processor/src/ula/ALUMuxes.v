module ALUMuxes #(
    parameter integer DWIDTH = 32   //! Largura dos dados armazenados
)(
    input wire [DWIDTH-1:0] instr,
    input wire [DWIDTH-1:0] immed,
    input wire [4:0] Rd1,
    input wire [4:0] Rd2,
  output reg [DWIDTH:0] operand_b,
    output reg [DWIDTH:0] operand_a

);

    // Instructions parameters
    parameter INST_LW   = 0;
    parameter INST_SW   = 1;

    parameter INST_ADD  = 3;
    parameter INST_SUB  = 4;
    parameter INST_MUL  = 5;
    parameter INST_DIV  = 6;

    parameter INST_AND  = 7;
    parameter INST_OR   = 8;
    parameter INST_SHL  = 9;
    parameter INST_SHR  = 10;
    parameter INST_CMP  = 11;
    parameter INST_NOT  = 12;

    reg [4:0] instruction_type;

    always @(*)
    begin : update_instruction_type
        instruction_type = instr[31:27];
    end

    always @(*)
    begin : mux_selection
        case (instruction_type)
            // Data Transfer operations
            INST_LW, INST_SW: begin
                operand_a = Rd2;
                operand_b = immed;
            end
            // Logic and Arithmetic operations
            INST_ADD, INST_SUB, INST_MUL, INST_DIV, INST_AND, INST_OR, INST_SHL, INST_SHR, INST_CMP, INST_NOT : begin
                operand_a = Rd1;
                operand_b = Rd2;
            end
        endcase
    end
endmodule
