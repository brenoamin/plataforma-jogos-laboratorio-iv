module ula (
    input wire [31:0] operand_a,
    input wire [31:0] operand_b,
  	input wire [31:0] inst,

    output reg [31:0] result,

    output reg equal,
    output reg above,
    output reg below,
    output reg overflow,
    output reg error   
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
        below       = 0;
        above       = 0;
        equal       = 0;
        overflow    = 0;
        error       = 0;
		result = 0;
        case (inst[31:27])
            ADD: begin
                result = operand_a + operand_b;
                if (result < operand_a) begin
                    overflow = 1;
                end
            end
            SUB: begin
                result = operand_a - operand_b;
                if (result > operand_a) begin
                    overflow = 1;
                end
            end
            MUL: begin
                result = operand_a * operand_b;
                if (operand_a != 0 && result / operand_a != operand_b) begin
                    overflow = 1;
                end
            end
            DIV: begin
                if (operand_b != 0) begin
                    result = operand_a / operand_b;
                    if (operand_a == 32'h80000000 && operand_b == 32'hffffffff) begin
                        overflow = 1;
                    end
                end else begin
                    result = 32'b0;
                    error = 1;
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
                    equal = 1;
                end else if (operand_a > operand_b) begin
                    above = 1;
                end else begin
                    below = 1;
                end
            end
            default: begin
                result = 0;
            end
        endcase
    end
endmodule