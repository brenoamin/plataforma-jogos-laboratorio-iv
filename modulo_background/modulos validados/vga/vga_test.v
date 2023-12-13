module vga_test(
    VGA_CLK,
    reset,
    VGA_R,
    VGA_G,
    VGA_B,
    VGA_BLANK_N,
    VGA_VS,
    VGA_HS
);

output  [7:0] VGA_R;
output  [7:0] VGA_G;
output  [7:0] VGA_B;
output VGA_BLANK_N;
output VGA_VS;
output VGA_HS;

input VGA_CLK, reset;

reg[9:0] count_h;
reg[9:0] count_v;

reg [7:0] color_r;
reg [7:0] color_g;
reg [7:0] color_b;

always @(posedge VGA_CLK) begin
    if (reset) begin
        count_h <= 0;
        count_v <= 0;
    end
    else begin
        count_h <= count_h + 1;
    end
    if (count_h == 799) begin
        count_h <= 0;
        count_v <= count_v + 1;
    end
    if (count_v == 525) begin
        count_v <= 0;
    end
end

assign VGA_HS = (count_h < 95) ? 1'b0: 1'b1;
assign VGA_VS = (count_v < 2) ? 1'b0: 1'b1;
assign VGA_BLANK_N = (count_h < 143) || (count_h > 778) || (count_v < 35) || (count_v > 515) ? 1'b0: 1'b1;

always @* begin
    // Modifique essas equações para criar padrões de cores diferentes
    color_r = (count_h % 256);
    color_g = (count_v % 256);
    color_b = ((count_h + count_v) % 256);
end

assign VGA_R = color_r;
assign VGA_G = color_g;
assign VGA_B = color_b;

endmodule
