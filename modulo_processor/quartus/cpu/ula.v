module ula #(
    parameter integer DWIDTH = 32,   //! Largura dos dados armazenados
    parameter integer FWIDTH = 2   //! Largura das flags
)(
    input wire [DWIDTH-1:0] operand_a,
    input wire [DWIDTH-1:0] operand_b,
    input wire [DWIDTH-1:0] ula_instr,

    output reg [DWIDTH-1:0] result,
    output reg below,
    output reg equal,
    output reg above,
    output reg errorFlag
);

    // Paramenters ALU
    localparam ADD = 4'b0011;
    localparam SUB = 4'b0100;
    localparam MUL = 4'b0101;
    localparam DIV = 4'b0110;
    localparam AND = 4'b0111;
    localparam OR  = 4'b1000;
    localparam SHL = 4'b1001;
    localparam SHR = 4'b1010;
    localparam CMP = 4'b1011;
    localparam NOT = 4'b1100;

    always @* begin
        case (ula_instr[31:27])
            ADD: begin
                result = operand_a + operand_b;
            end
            SUB: begin
                result = operand_a - operand_b;
            end
            MUL: begin
                result = operand_a * operand_b;
            end
            DIV: begin
                if (operand_b != 0) begin
                    result = operand_a / operand_b;
                end else begin
                    result = 32'b0;
                    errorFlag = 1;
                end
            end
            AND: begin
                result = operand_a & operand_b;
            end
            OR: begin
                result = operand_a | operand_b;
            end
            NOT: begin
                result = ~operand_a;
            end
            SHL: begin
                result = operand_a << operand_b;
            end
            SHR: begin
                result = operand_a >> operand_b;
            end
            CMP: begin
                if (operand_a == operand_b) begin
                    equal = 1; 	// Igual
                end else if (operand_a > operand_b) begin
                    above = 1; 	// Primeiro maior
                end else begin
                    below = 1; 	// Segundo maior
                end
            end
            default: begin
					result = 32'hx;
                    errorFlag = 0;
                    equal = 0;
                    above = 0;
                    below = 0;
            end
        endcase
    end
endmodule

