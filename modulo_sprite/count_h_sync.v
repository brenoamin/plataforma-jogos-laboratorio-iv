module count_h_sync(
    input wire clk,
    input wire rst,
    input wire h_sync,
    input wire v_sync,
    output reg [9:0] V_pos_out
);

   reg [9:0] V_pos ;

    always @(*) begin
		if (v_sync|!rst) begin
			V_pos <= 0;
		end else begin
			if (h_sync) begin
				V_pos <= V_pos + 1'b1;
			end
		end
	V_pos_out <= V_pos;
    end

endmodule
