module count_px_clk(
    input wire clk,
    input wire rst,
    input wire pixel_clk,
    input wire h_sync,

    output reg [9:0] H_pos_00,		//Posições dos 16bits para varredura e busca na memória
	output reg [9:0] H_pos_01,
	output reg [9:0] H_pos_02,
	output reg [9:0] H_pos_03,
	output reg [9:0] H_pos_04,
	output reg [9:0] H_pos_05,
	output reg [9:0] H_pos_06,
	output reg [9:0] H_pos_07,
	output reg [9:0] H_pos_08,
	output reg [9:0] H_pos_09,
	output reg [9:0] H_pos_10,
	output reg [9:0] H_pos_11,
	output reg [9:0] H_pos_12,
	output reg [9:0] H_pos_13,
	output reg [9:0] H_pos_14,
	output reg [9:0] H_pos_15

);


    reg [3:0] H_pos_count;

    initial
    begin
        H_pos_count = 0;
        H_pos_00 = 0;
        H_pos_01 = 1;
        H_pos_02 = 2;
        H_pos_03 = 3;
        H_pos_04 = 4;
        H_pos_05 = 5;
        H_pos_06 = 6;
        H_pos_07 = 7;
        H_pos_08 = 8;
        H_pos_09 = 9;
        H_pos_10 = 10;
        H_pos_11 = 11;
        H_pos_12 = 12;
        H_pos_13 = 13;
        H_pos_14 = 14;
        H_pos_15 = 15;
    end

    always @(posedge pixel_clk) begin
        H_pos_count <= H_pos_count + 1;
        if (H_pos_count >= 16) begin
            H_pos_count <= 0;
            H_pos_00 <= H_pos_00 + 10'd16;
            H_pos_01 <= H_pos_01 + 10'd16;
            H_pos_02 <= H_pos_02 + 10'd16;
            H_pos_03 <= H_pos_03 + 10'd16;
            H_pos_04 <= H_pos_04 + 10'd16;
            H_pos_05 <= H_pos_05 + 10'd16;
            H_pos_06 <= H_pos_06 + 10'd16;
            H_pos_07 <= H_pos_07 + 10'd16;
            H_pos_08 <= H_pos_08 + 10'd16;
            H_pos_09 <= H_pos_09 + 10'd16;
            H_pos_10 <= H_pos_10 + 10'd16;
            H_pos_11 <= H_pos_11 + 10'd16;
            H_pos_12 <= H_pos_12 + 10'd16;
            H_pos_13 <= H_pos_13 + 10'd16;
            H_pos_14 <= H_pos_14 + 10'd16;
            H_pos_15 <= H_pos_15 + 10'd16;

        end
    end

    always @(posedge clk or negedge rst or posedge h_sync) begin
        if (rst | h_sync) begin
            H_pos_count <= 10'd0;
            H_pos_00 <= 10'd0;
            H_pos_01 <= 10'd0;
            H_pos_02 <= 10'd0;
            H_pos_03 <= 10'd0;
            H_pos_04 <= 10'd0;
            H_pos_05 <= 10'd0;
            H_pos_06 <= 10'd0;
            H_pos_07 <= 10'd0;
            H_pos_08 <= 10'd0;
            H_pos_09 <= 10'd0;
            H_pos_10 <= 10'd0;
            H_pos_11 <= 10'd0;
            H_pos_12 <= 10'd0;
            H_pos_13 <= 10'd0;
            H_pos_14 <= 10'd0;
            H_pos_15 <= 10'd0;
        end
    end

//assign count = (H_pos_in >= 144) ? H_pos_in - 144 : 0;

endmodule

