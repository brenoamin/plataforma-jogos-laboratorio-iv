//! @title Registrador de Decode
//! @author @LeandroGama

module decode #(
    parameter DWIDTH = 32                   //! Largura dos dados armazenados
  )(
    input wire clk,                         //! Sinal de clock
    input wire rst,                         //! Sinal de reset
    input wire [DWIDTH-1:0] addr,           //! Endereço de leitura da Memória de Programa
    input wire [DWIDTH-1:0] immed,          //! Imediato
    input wire [DWIDTH-1:0] inst,           //! Instrução de entrada
    input wire [DWIDTH-1:0] Rd1,            //! Registrador d1
    input wire [DWIDTH-1:0] Rd2,            //! Registrador d2

    output reg [DWIDTH-1:0] stored_addr,    //! Endereço de leitura da Memória de Programa fornecido ao próximo estágio
    output reg [DWIDTH-1:0] stored_immed,   //! Imediato fornecido ao próximo estágio
    output reg [DWIDTH-1:0] stored_inst,    //! Instrução fornecida ao próximo estágio
    output reg [DWIDTH-1:0] stored_Rd1,     //! Registrador d1 fornecida ao próximo estágio
    output reg [DWIDTH-1:0] stored_Rd2,     //! Registrador d2 fornecida ao próximo estágio
    output reg [4:0] R                      //! Registrador de jumps
);

    // Parameters Transfers control
    localparam JR = 5'b01101;
    localparam JPC = 5'b01110;
    localparam CALL = 5'b10000;

    reg [4:0] instruction_type= 5'b10000;

    always @(inst) 
    begin : update_instruction_type
        instruction_type = inst[31:27];
    end

    //! Lógica para armazenar dados, instruções e flags de status
    always @(posedge clk or posedge rst)
    begin : Decode
        if (rst) begin
            stored_addr   <= 0;
            stored_immed  <= 0;
            stored_inst   <= 0;
            stored_Rd1    <= 0;
            stored_Rd2    <= 0;
            R              <= 0;          
        end
        else begin
            stored_addr  <= addr;
            stored_immed <= immed;
            stored_inst  <= inst;
            stored_Rd1   <= Rd1;
            stored_Rd2   <= Rd2;

            case (instruction_type)
                JR, CALL, JPC: begin
                    R <= inst[14:10];
                end
                default: begin
                    R <= 0;
                end
            endcase
        end
    end

endmodule
