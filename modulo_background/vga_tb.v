module vga_tb;

reg clk = 0;
wire vga_h_sync, vga_v_sync, inDisplayArea;
wire [9:0] CounterX, CounterY;

vga screen (
    .clk(clk),
    .vga_h_sync(vga_h_sync),
    .vga_v_sync(vga_v_sync),
    .inDisplayArea(inDisplayArea),
    .CounterX(CounterX),
    .CounterY(CounterY)
);

always #1 clk = ~clk;

reg [7:0] header [0:53] = {
    8'h42, 8'h4D, 8'h36, 8'h10, 8'h0E, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h36, 8'h00,
    8'h00, 8'h00, 8'h28, 8'h00, 8'h00, 8'h00, 8'h80, 8'h02, 8'h00, 8'h00, 8'hE0, 8'h01,
    8'h00, 8'h00, 8'h01, 8'h00, 8'h18, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h10,
    8'h0E, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
    8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00
};


integer file_out;

reg [64*8-1:0] fileName_out = "vga_out.bmp";

localparam [9:0] min_x = 64;
localparam [9:0] min_y = 16;
localparam [9:0] max_x = 640 + min_x - 1;
localparam [9:0] max_y = 480 + min_y - 1;

integer i = 0;

initial begin
    file_out = $fopen(fileName_out, "wb"); 
    if (!file_out) begin
        $error("File could not be open: ", fileName_out);
        $stop();
    end

    for(i = 0; i < 54; i = i + 1) begin
        $fwrite(file_out, "%c", header[i]);
    end

end

always @(CounterX or CounterY) begin
    if (inDisplayArea) begin
        $fwrite(file_out, "%c%c%c", 8'hCC, 8'hBB, 8'hAA);
    end else if (CounterY >= max_y && CounterX >= max_x) begin
        $fclose(file_out);
        $stop();
    end
end

endmodule
