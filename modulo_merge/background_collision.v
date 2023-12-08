module background_collision (clk, rst, R_bg, G_bg, B_bg, ancora_bg_X, ancora_sp_X, ancora_bg_Y, ancora_sp_Y,
                        max_R_top, max_G_top, max_B_top, min_R_top, min_G_top, min_B_top, avg_R_top, avg_G_top, avg_B_top,
                        max_R_bottom, max_G_bottom, max_B_bottom, min_R_bottom, min_G_bottom, min_B_bottom, avg_R_bottom, avg_G_bottom, avg_B_bottom,
                        max_R_right, max_G_right, max_B_right, min_R_right, min_G_right, min_B_right, avg_R_right, avg_G_right, avg_B_right,
                        max_R_left, max_G_left, max_B_left, min_R_left, min_G_left, min_B_left, avg_R_left, avg_G_left, avg_B_left
                        );


	input wire clk, rst;
	input wire [7:0] R_bg ,G_bg, B_bg;
	input wire [9:0] ancora_bg_X, ancora_sp_X, ancora_bg_Y, ancora_sp_Y;
	output reg [7:0] max_R_top, max_G_top, max_B_top, min_R_top, min_G_top, min_B_top, avg_R_top, avg_G_top, avg_B_top;
	output reg [7:0] max_R_bottom, max_G_bottom, max_B_bottom, min_R_bottom, min_G_bottom, min_B_bottom, avg_R_bottom, avg_G_bottom, avg_B_bottom;
	output reg [7:0] max_R_right, max_G_right, max_B_right, min_R_right, min_G_right, min_B_right, avg_R_right, avg_G_right, avg_B_right;
	output reg [7:0] max_R_left, max_G_left, max_B_left, min_R_left, min_G_left, min_B_left, avg_R_left, avg_G_left, avg_B_left;



	reg [11:0] R_sum_top = 12'b0;
	reg [11:0] G_sum_top = 12'b0;
	reg [11:0] B_sum_top = 12'b0;

	reg [11:0] R_sum_bottom = 12'b0;
	reg [11:0] G_sum_bottom = 12'b0;
	reg [11:0] B_sum_bottom = 12'b0;

	reg [11:0] R_sum_right = 12'b0;
	reg [11:0] G_sum_right = 12'b0;
	reg [11:0] B_sum_right = 12'b0;

	reg [11:0] R_sum_left = 12'b0;
	reg [11:0] G_sum_left = 12'b0;
	reg [11:0] B_sum_left = 12'b0;


    always@(posedge clk)
    begin
        if (rst)
        begin
            //Topo do sprite
            max_R_top <= 8'b0;
            max_G_top <= 8'b0;
            max_B_top <= 8'b0;
            min_R_top <= 8'b11111111;
            min_G_top <= 8'b11111111;
            min_B_top <= 8'b11111111;
            avg_R_top <= 8'b0;
            avg_G_top <= 8'b0;
            avg_B_top <= 8'b0;
            //Base do sprite
            max_R_bottom <= 8'b0; 
            max_G_bottom <= 8'b0; 
            max_B_bottom <= 8'b0;
            min_R_bottom <= 8'b11111111;
            min_G_bottom <= 8'b11111111;
            min_B_bottom <= 8'b11111111;
            avg_R_bottom <= 8'b0;
            avg_G_bottom <= 8'b0;
            avg_B_bottom <= 8'b0;
            //Lado direito do sprite
            max_R_right <= 8'b0; 
            max_G_right <= 8'b0;
            max_B_right <= 8'b0;
            min_R_right <= 8'b11111111;
            min_G_right <= 8'b11111111;
            min_B_right <= 8'b11111111;
            avg_R_right <= 8'b0;
            avg_G_right <= 8'b0;
            avg_B_right <= 8'b0;
            //Lado esquerdo
            max_R_left <= 8'b0; 
            max_G_left <= 8'b0;
            max_B_left <= 8'b0;
            min_R_left <= 8'b11111111;
            min_G_left <= 8'b11111111;
            min_B_left <= 8'b11111111;
            avg_R_left <= 8'b0;
            avg_G_left <= 8'b0;
            avg_B_left <= 8'b0;

        end else begin

            //Lógica para topo
            if (ancora_bg_X == ancora_sp_X && ancora_bg_Y >= ancora_sp_Y && ancora_bg_Y <= (ancora_sp_Y + 15))
            begin

                if (R_bg > max_R_top)
                    max_R_top <= R_bg;
                if (R_bg < min_R_top)
                    min_R_top <= R_bg;

                if (G_bg > max_G_top)
                    max_G_top <= G_bg;
                if (G_bg < min_G_top)
                    min_G_top <= G_bg;

                if (B_bg > max_B_top)
                    max_B_top <= B_bg;
                if (B_bg < min_B_top)
                    min_B_top <= B_bg;


                R_sum_top <= R_sum_top + R_bg;
                G_sum_top <= G_sum_top + G_bg;
                B_sum_top <= B_sum_top + B_bg;

                avg_R_top <= R_sum_top / 16;
                avg_G_top <= G_sum_top / 16;
                avg_B_top <= B_sum_top / 16;
                
            end


             //Lógica para bottom
            else if (ancora_bg_X  == (ancora_sp_X + 15) && ancora_bg_Y >= ancora_sp_Y && ancora_bg_Y <= (ancora_sp_Y + 15))
            begin

                if (R_bg > max_R_bottom)
                    max_R_bottom <= R_bg;
                if (R_bg < min_R_bottom)
                    min_R_bottom <= R_bg;

                if (G_bg > max_G_bottom)
                    max_G_bottom <= G_bg;
                if (G_bg < min_G_bottom)
                    min_G_bottom <= G_bg;

                if (B_bg > max_B_bottom)
                    max_B_bottom <= B_bg;
                if (B_bg < min_B_bottom)
                    min_B_bottom <= B_bg;


                R_sum_bottom <= R_sum_bottom + R_bg;
                G_sum_bottom <= G_sum_bottom + G_bg;
                B_sum_bottom <= B_sum_bottom + B_bg;
                
                avg_R_bottom <= R_sum_bottom / 16;
                avg_G_bottom <= G_sum_bottom / 16;
                avg_B_bottom <= B_sum_bottom / 16;
                
            end

            //Lógica para right
            else if (ancora_bg_X >= ancora_sp_X && ancora_bg_X <= (ancora_sp_X + 15)  && ancora_bg_Y == (ancora_sp_Y + 15))
            begin

                if (R_bg > max_R_right)
                    max_R_right <= R_bg;
                if (R_bg < min_R_right)
                    min_R_right <= R_bg;

                if (G_bg > max_G_right)
                    max_G_right <= G_bg;
                if (G_bg < min_G_right)
                    min_G_right <= G_bg;

                if (B_bg > max_B_right)
                    max_B_right <= B_bg;
                if (B_bg < min_B_right)
                    min_B_right <= B_bg;


                R_sum_right <= R_sum_right + R_bg;
                G_sum_right <= G_sum_right + G_bg;
                B_sum_right <= B_sum_right + B_bg;
                
                avg_R_right <= R_sum_right / 16;
                avg_G_right <= G_sum_right / 16;
                avg_B_right <= B_sum_right / 16;
                
            end


            //Lógica para left
            else if (ancora_bg_X >= ancora_sp_X && ancora_bg_X <= (ancora_sp_X + 15)  && ancora_bg_Y == (ancora_sp_Y))
            begin

                if (R_bg > max_R_left)
                    max_R_left <= R_bg;
                if (R_bg < min_R_left)
                    min_R_left <= R_bg;

                if (G_bg > max_G_left)
                    max_G_left <= G_bg;
                if (G_bg < min_G_left)
                    min_G_left <= G_bg;

                if (B_bg > max_B_left)
                    max_B_left <= B_bg;
                if (B_bg < min_B_left)
                    min_B_left <= B_bg;


                R_sum_left <= R_sum_left + R_bg;
                G_sum_left <= G_sum_left + G_bg;
                B_sum_left <= B_sum_left + B_bg;
                
                avg_R_left <= R_sum_left / 16;
                avg_G_left <= G_sum_left / 16;
                avg_B_left <= B_sum_left / 16;
                
            end
     
        end

    end


endmodule