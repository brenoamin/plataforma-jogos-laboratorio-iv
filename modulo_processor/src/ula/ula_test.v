module ula_tb;

    // Parâmetros
    parameter CLK_PERIOD = 10; // Período do clock em unidades de tempo

    // Sinais
    reg clk;
    reg [31:0] operand_a, operand_b;
    reg [3:0] opcode;
    wire [31:0] result;
    wire overflow;
    wire [1:0] compareResult;

    // Instância da ULA
    ula uut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .opcode(opcode),
        .result(result),
        .overflow(overflow),
        .compareResult(compareResult)
    );

    // Geração de clock
    initial begin
        clk = 0;
        forever #((CLK_PERIOD/2)) clk = ~clk;
    end

    // Teste das operações
    initial begin
        // Teste de ADD
        operand_a = 5;
        operand_b = 10;
        opcode = 4'b0000; // ADD
        #100 $display("ADD: %d + %d = %d", operand_a, operand_b, result);

        // Teste de SUB
        operand_a = 20;
        operand_b = 8;
        opcode = 4'b0001; // SUB
        #100 $display("SUB: %d - %d = %d", operand_a, operand_b, result );

        // Teste de MUL
        operand_a = 7;
        operand_b = 3;
        opcode = 4'b0010; // MUL
        #100 $display("MUL: %d * %d = %d", operand_a, operand_b, result);

        // Teste de DIV
        operand_a = 50;
        operand_b = 10;
        opcode = 4'b0011; // DIV
        #100 $display("DIV: %d / %d = %d", operand_a, operand_b, result);

        // Teste de AND
        operand_a = 1;
        operand_b = 1;
        opcode = 4'b0100; // AND
        #100 $display("AND: %b & %b = %b", operand_a, operand_b, result);

        // Teste de OR
        operand_a = 1;
        operand_b = 0;
        opcode = 4'b0101; // OR
        #100 $display("OR: %b | %b = %b", operand_a, operand_b, result);

        // Teste de NOT
        operand_a = 1;
        operand_b = 0;
        opcode = 4'b0110; // NOT
        #100 $display("NOT: ~%b = %b", operand_a, result);

        // Teste de SHL
        operand_a = 8'b00111100;
        operand_b = 2;
        opcode = 4'b0111; // SHL
        #100 $display("SHL: %b << %d = %b", operand_a, operand_b, result);

        // Teste de SHR
        operand_a = 8'b00111100;
        operand_b = 1;
        opcode = 4'b1000; // SHR
        #100 $display("SHR: %b >> %d = %b", operand_a, operand_b, result);

        // Teste de CMP
        operand_a = 10;
        operand_b = 20;
        opcode = 4'b1001; // CMP
        #100 $display("CMP: %d, %d - compareResult: %d", operand_a, operand_b, compareResult);

        // Adicione mais testes conforme necessário

        // Finaliza a simulação
        #100 $finish;
    end

endmodule

