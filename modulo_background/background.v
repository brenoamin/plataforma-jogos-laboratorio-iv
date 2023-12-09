module background (
    input wire clk,           // Sinal de clock
    input wire rst,           // Sinal de reset
    input wire [9:0] row,     // Posição da linha da imagem
    input wire [9:0] col,     // Posição da coluna da imagem
    input wire [7:0] r_in,    // Canal R de entrada da SDRAM
    input wire [7:0] g_in,    // Canal G de entrada da SDRAM
    input wire [7:0] b_in,    // Canal B de entrada da SDRAM
    output reg [7:0] r_out,   // Canal R de saída
    output reg [7:0] g_out,   // Canal G de saída
    output reg [7:0] b_out,   // Canal B de saída
    output reg [9:0] x_out,   // Posição X de saída
    output reg [9:0] y_out    // Posição Y de saída
);

// Parâmetros para o tamanho da tela e da imagem
parameter SCREEN_WIDTH = 800;
parameter SCREEN_HEIGHT = 600;
parameter IMAGE_WIDTH = 640;
parameter IMAGE_HEIGHT = 480;

// Parâmetros para a posição inicial da imagem
parameter INITIAL_ROW = 0;
parameter INITIAL_COL = 0;

// Registros de estado
reg [9:0] current_row;
reg [9:0] current_col;

// Lógica de controle
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Resetando os registros de estado
        current_row <= INITIAL_ROW;
        current_col <= INITIAL_COL;
        r_out <= 8'b0;
        g_out <= 8'b0;
        b_out <= 8'b0;
        x_out <= 10'b0;
        y_out <= 10'b0;
    end else begin
        // Atualizando a posição da imagem com base na entrada PUT_IMAGE
        if (row < SCREEN_HEIGHT && col < SCREEN_WIDTH) begin
            current_row <= row;
            current_col <= col;
        end

        // Gerando a saída RGB com base na posição atual
        r_out <= r_in;
        g_out <= g_in;
        b_out <= b_in;

        // Sinais de saída para a posição
        x_out <= current_col;
        y_out <= current_row;
    end
end

endmodule
