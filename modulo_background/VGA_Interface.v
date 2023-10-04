module VGA_Interface(
 
	clk,
	rst,
	R_in,
	G_in,
	B_in,
 
	oAddress,
	R,G,B,
	BLANK,
	VGA_SYNC,
	VGA_CLK,
	HS,VS,
	v_pos,
	h_pos
); 
 
	input [7:0] R_in, G_in, B_in;
	input clk, rst;
 
	output reg [7:0] R, G, B;
	output reg HS, VS;
	output reg BLANK;
	output VGA_SYNC, VGA_CLK;
 
	output reg [9:0] h_pos, v_pos;
	output reg [19:0]	oAddress;
 
	parameter H_FRONT = 16;	//16
	parameter H_SYNC = 96;	//96
	parameter H_BACK = 48;	//48
	parameter H_DISPLAY = 640;
	parameter H_BLANK = H_SYNC+H_BACK;
	parameter H_TOTAL = H_FRONT+H_SYNC+H_BACK+H_DISPLAY;
 
	parameter V_FRONT = 10;	//12
	parameter V_SYNC = 2;	//2
	parameter V_BACK = 33;	//31
	parameter V_DISPLAY	= 480;
	parameter V_BLANK = V_SYNC+V_BACK;
	parameter V_TOTAL = V_FRONT+V_SYNC+V_BACK+V_DISPLAY;
 
 
	always @(posedge clk)
	begin
		if (rst == 1'b1)
		begin
			h_pos <= 10'b0000000000;
			v_pos <= 10'b0000000000;
		end
 
		else
		begin
			if (h_pos<H_TOTAL-1)//800 pulsos
			begin
				h_pos <= h_pos + 1'b1;
			end		
 
			else
			begin
				h_pos <= 1'b0;
 
				if (v_pos<V_TOTAL-1)//525 pulsos
				begin
					v_pos <= v_pos + 1'b1;
				end
 
				else
				begin
					v_pos <= 1'b0;
				end
			end
		end
	end
 
	// Sincronismo Horizontal
	always @(posedge clk)
	begin
		if (rst == 1'b1)
		begin
			HS <= 1'b1;
		end
		else
		begin
			if ( (h_pos > H_BACK+H_DISPLAY+H_FRONT-1) && (h_pos < H_TOTAL) )
			begin
				HS <= 1'b0;
			end
			else
			begin
				HS <= 1'b1;
			end
		end
	end
 
	// Sincronismo Vertical
	always @(posedge clk)
	begin
		if (rst == 1'b1)
		begin
			VS <= 1'b1;
		end
		else
		begin
			if ( (v_pos > V_BACK+V_DISPLAY+V_FRONT-1) && (v_pos < V_TOTAL) )
			begin
				VS <= 1'b0;
			end
			else
			begin
				VS <= 1'b1;
			end
		end
	end
 
	// Blank
	always @(posedge clk)
	begin
		if (rst == 1'b1)
		begin
			BLANK <= 1'b1;
		end
		else
		begin
			if ( (h_pos<H_BACK) || (h_pos > H_BACK+H_DISPLAY-1) || (v_pos<V_BACK) || (v_pos > V_BACK+V_DISPLAY-1) )
			begin
				BLANK <= 1'b0;
			end
			else
			begin
				BLANK <= 1'b1;
			end
		end
	end
 
	assign VGA_CLK = clk;
	assign VGA_SYNC = 1'b0;
 
	always @(posedge clk )
	begin
		R <= R_in;
		G <= G_in;
		B <= B_in;
	end
 
 
	// Bloco para geracao dos enderecos de cada pixel na memoria
	// Cada pixel está guardado em um endereco diferente, sequencialmente
	always @(posedge clk )
	begin
 
		// Reset no circuito, endereco vai para zero
		if (rst == 1'b1)
		begin
			oAddress <= 20'h00000;
		end
 
		// Operacao normal, apos reset
		else
		begin
			// Operacao na parte visivel do video
			if( (h_pos>H_BACK-1) && (h_pos < H_BACK+H_DISPLAY) && (v_pos>V_BACK-1) && (v_pos < V_BACK+V_DISPLAY) )
			begin
 
				// Enquanto nao tiver atingido o ultimo pixel
				if ( oAddress < ((H_DISPLAY*V_DISPLAY) - 1)  )
				begin
					oAddress <= oAddress + 1'b1;
				end
 
				// Retorna para o inicio apos atingir o ultimo pixel
				else
				begin
					oAddress <= 1'b0;
				end
 
			end
 
			// Operacao na parte de sincronismo do video
			else
			begin
				oAddress <= oAddress;
			end
		end
	end
 
endmodule
