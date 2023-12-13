module muxula #(
    parameter integer DWIDTH = 32   //! Largura dos dados armazenados
)(
    input wire [DWIDTH-1:0] alu_instr,
    input wire [DWIDTH-1:0] immed,
    input wire [DWIDTH-1:0] Rd1,
    input wire [DWIDTH-1:0] Rd2,
	 output reg [DWIDTH-1:0] operand_b,
    output reg [DWIDTH-1:0] operand_a

);

    // Instructions localparams
    localparam INST_LW   = 0;
    localparam INST_SW   = 1;

    localparam INST_ADD  = 3;
    localparam INST_SUB  = 4;
    localparam INST_MUL  = 5;
    localparam INST_DIV  = 6;

    localparam INST_AND  = 7;
    localparam INST_OR   = 8;
    localparam INST_SHL  = 9;
    localparam INST_SHR  = 10;
    localparam INST_CMP  = 11;
    localparam INST_NOT  = 12;

    reg [4:0] instruction_type;

    always @(*)
    begin : update_instruction_type
        instruction_type = alu_instr[31:27];
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
            default: begin
                operand_a = 'hx;
                operand_b = 'hx;
            end
        endcase
    end
endmodule
