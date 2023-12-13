module ula (
    input wire [31:0] operand_a,
    input wire [31:0] operand_b,
    input wire [3:0] opcode,

    output reg [31:0] result,
    output reg [1:0] overflow,
    output reg [1:0] compareResult,
    output reg [1:0] errorFlag
);

    // Paramenters ALU
    parameter ADD = 4'b0011;
    parameter SUB = 4'b0100;
    parameter MUL = 4'b0101;
    parameter DIV = 4'b0110;
    parameter AND = 4'b0111;
    parameter OR  = 4'b1000;
    parameter SHL = 4'b1001;
    parameter SHR = 4'b1010;
    parameter CMP = 4'b1011;
    parameter NOT = 4'b1100;

    always @* begin
        case (opcode)
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
                    compareResult = 2'b00; 	// Igual
                end else if (operand_a > operand_b) begin
                    compareResult = 2'b01; 	// Primeiro maior
                end else begin
                    compareResult = 2'b10; 	// Segundo maior
                end
            end
            default: begin
		result = 32'b0;
            end
        endcase
    end
endmodule

