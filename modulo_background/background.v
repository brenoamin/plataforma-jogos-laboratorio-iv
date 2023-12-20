module background (
    input wire clk,           // Sinal de clock
    input wire rst,           // Sinal de reset
    input wire [9:0] anchor_x, // Posição da linha da imagem
    input wire [9:0] anchor_y, // Posição da coluna da imagem
    input wire [15:0] ram_data, // Dados da RAM de 16 bits
    output reg [7:0] r_out,    // Canal R de saída
    output reg [7:0] g_out,    // Canal G de saída
    output reg [7:0] b_out,    // Canal B de saída
    output reg [9:0] x_out,    // Posição X de saída
    output reg [9:0] y_out     // Posição Y de saída
);

// Parâmetros para o tamanho da tela e da imagem
parameter SCREEN_WIDTH = 800;
parameter SCREEN_HEIGHT = 600;
parameter IMAGE_WIDTH = 640;
parameter IMAGE_HEIGHT = 480;

// Parâmetros para a posição inicial da imagem
parameter INITIAL_anchor_x = 0;
parameter INITIAL_anchor_y = 0;

// Registros de estado
reg [9:0] current_anchor_x;
reg [9:0] current_anchor_y;

// Memória SDRAM
reg [15:0] sdram [0:1048575]; // 4 bancos de 1.048.576 palavras de 16 bits

// Contador para inicialização da memória no sinal de reset
reg [19:0] init_counter;

// Lógica de controle
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Resetando os registros de estado e a memória SDRAM
        current_anchor_x <= INITIAL_anchor_x;
        current_anchor_y <= INITIAL_anchor_y;
        r_out <= 8'b0;
        g_out <= 8'b0;
        b_out <= 8'b0;
        x_out <= 10'b0;
        y_out <= 10'b0;

        // Inicializando a memória SDRAM sem utilizar loop
        if (init_counter < 1048576) begin
            sdram[init_counter] <= 16'b0;
            init_counter <= init_counter + 1;
        end else begin
            init_counter <= 0;
        end
    end else begin
        // Atualizando a posição da imagem com base na entrada PUT_IMAGE
        if (anchor_x < SCREEN_HEIGHT && anchor_y < SCREEN_WIDTH) begin
            current_anchor_x <= anchor_x;
            current_anchor_y <= anchor_y;

            // Acessando a SDRAM com base nas posições (current_anchor_x, current_anchor_y)
            // Suponha que os dados tenham sido previamente carregados na SDRAM
            r_out <= sdram[current_anchor_x + current_anchor_y * SCREEN_HEIGHT][7:0];
            g_out <= sdram[current_anchor_x + current_anchor_y * SCREEN_HEIGHT][11:8];
            b_out <= sdram[current_anchor_x + current_anchor_y * SCREEN_HEIGHT][15:12];
        end

        // Sinais de saída para a posição
        x_out <= current_anchor_x;
        y_out <= current_anchor_y;
    end
end

endmodule
