module muxbank #(
    parameter integer DWIDTH = 32,   //! Largura dos dados armazenados
    parameter integer MWIDTH = 5   //! Largura dos dados armazenados
)(
    input wire [DWIDTH-1:0] fetch_instr,

    output reg [MWIDTH-1:0] addr_1,
    output reg [MWIDTH-1:0] addr_2,
    output reg read_en

);

    // Instructions localparams
    localparam INST_LW   = 0;
    localparam INST_SW   = 1;
    localparam INST_MOV   = 2;

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
        instruction_type = fetch_instr[31:27];
    end

    always @(*)
    begin : mux_selection
        case (instruction_type)
            // Data Transfer operations
            INST_LW, INST_MOV, INST_ADD, INST_SUB, INST_MUL, INST_DIV, INST_AND, INST_OR, INST_SHL, INST_SHR, INST_CMP, INST_NOT : begin
                addr_1 = fetch_instr[26:22];
                addr_2 = fetch_instr[4:0];
                read_en = 1;
            end
            // Logic and Arithmetic operations
            INST_SW: begin
                addr_1 = fetch_instr[26:22];
                addr_2 = fetch_instr[4:0];
                read_en = 0;
            end
            default: begin
                addr_1 = 0;
                addr_2 = 0;
                read_en = 1;
            end
        endcase
    end
endmodule
