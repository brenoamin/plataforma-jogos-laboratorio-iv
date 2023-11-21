module count_h_sync(
    input wire clk,
    input wire rst,
    input wire h_sync,
	input wire v_sync,
    output reg [9:0] V_pos_in
);


    always @(posedge h_sync) begin
        V_pos_in <= V_pos_in + 1;
    end

    always @(posedge v_sync) begin
        V_pos_in <= 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            V_pos_in <= 0;
        end
    end


endmodule
