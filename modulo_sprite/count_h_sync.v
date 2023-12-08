module count_h_sync(
    input wire clk,
    input wire rst,
    input wire h_sync,
	 input wire v_sync,
    output wire [9:0] V_pos_out
);

    always @(*) begin
		if (v_sync|!rst) begin
			V_pos_out <= 0;
		end else begin
			if (h_sync) begin
				V_pos_out <= V_pos_out + 1'b1;
			end
		end
    end

endmodule
