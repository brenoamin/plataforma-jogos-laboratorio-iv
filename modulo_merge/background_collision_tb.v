`timescale 1ns/1ns

module background_collision_tb;

  reg clk, rst;
  reg [7:0] R_bg, G_bg, B_bg;
  reg [9:0] ancora_bg_X, ancora_sp_X, ancora_bg_Y, ancora_sp_Y;
  wire [7:0] max_R_top, max_G_top, max_B_top, min_R_top, min_G_top, min_B_top, avg_R_top, avg_G_top, avg_B_top;
  wire [7:0] max_R_bottom, max_G_bottom, max_B_bottom, min_R_bottom, min_G_bottom, min_B_bottom, avg_R_bottom, avg_G_bottom, avg_B_bottom;
  wire [7:0] max_R_right, max_G_right, max_B_right, min_R_right, min_G_right, min_B_right, avg_R_right, avg_G_right, avg_B_right;
  wire [7:0] max_R_left, max_G_left, max_B_left, min_R_left, min_G_left, min_B_left, avg_R_left, avg_G_left, avg_B_left;

  // Instantiate the module
  background_collision uut (
    .clk(clk),
    .rst(rst),
    .R_bg(R_bg),
    .G_bg(G_bg),
    .B_bg(B_bg),
    .ancora_bg_X(ancora_bg_X),
    .ancora_sp_X(ancora_sp_X),
    .ancora_bg_Y(ancora_bg_Y),
    .ancora_sp_Y(ancora_sp_Y),
    .max_R_top(max_R_top),
    .max_G_top(max_G_top),
    .max_B_top(max_B_top),
    .min_R_top(min_R_top),
    .min_G_top(min_G_top),
    .min_B_top(min_B_top),
    .avg_R_top(avg_R_top),
    .avg_G_top(avg_G_top),
    .avg_B_top(avg_B_top),
    .max_R_bottom(max_R_bottom),
    .max_G_bottom(max_G_bottom),
    .max_B_bottom(max_B_bottom),
    .min_R_bottom(min_R_bottom),
    .min_G_bottom(min_G_bottom),
    .min_B_bottom(min_B_bottom),
    .avg_R_bottom(avg_R_bottom),
    .avg_G_bottom(avg_G_bottom),
    .avg_B_bottom(avg_B_bottom),
    .max_R_right(max_R_right),
    .max_G_right(max_G_right),
    .max_B_right(max_B_right),
    .min_R_right(min_R_right),
    .min_G_right(min_G_right),
    .min_B_right(min_B_right),
    .avg_R_right(avg_R_right),
    .avg_G_right(avg_G_right),
    .avg_B_right(avg_B_right),
    .max_R_left(max_R_left),
    .max_G_left(max_G_left),
    .max_B_left(max_B_left),
    .min_R_left(min_R_left),
    .min_G_left(min_G_left),
    .min_B_left(min_B_left),
    .avg_R_left(avg_R_left),
    .avg_G_left(avg_G_left),
    .avg_B_left(avg_B_left)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    rst = 1; // Initial reset state
    #10 rst = 0; // De-assert reset after 10 time units

    // Teste topo
    R_bg = 8'b00000001;
    G_bg = 8'b00000001;
    B_bg = 8'b00000001;
    ancora_bg_X = 5;
    ancora_bg_Y = 5;
    ancora_sp_X = 5;
    ancora_sp_Y = 5;
    #10;

    // Teste topo fim do sprit
    R_bg = 8'b00000111;
    G_bg = 8'b00000111;
    B_bg = 8'b00000111;
    ancora_bg_X = 5;
    ancora_bg_Y = 20;
    ancora_sp_X = 5;
    ancora_sp_Y = 5;
    #10;

    // Teste topo meio do sprit
    R_bg = 8'b00011111;
    G_bg = 8'b00011111;
    B_bg = 8'b00011111;
    ancora_bg_X = 5;
    ancora_bg_Y = 10;
    ancora_sp_X = 5;
    ancora_sp_Y = 5;
    #10;


    // Teste topo fora do sprite passando
    R_bg = 8'b11111111;
    G_bg = 8'b11111111;
    B_bg = 8'b11111111;
    ancora_bg_X = 5;
    ancora_bg_Y = 25;
    ancora_sp_X = 5;
    ancora_sp_Y = 5;
    #10;

    // Teste topo fora do sprite antes
    R_bg = 8'b00000000;
    G_bg = 8'b00000000;
    B_bg = 8'b00000000;
    ancora_bg_X = 5;
    ancora_bg_Y = 1;
    ancora_sp_X = 5;
    ancora_sp_Y = 5;
    #10;


    // Add more test cases as needed

    $stop;
  end

endmodule
