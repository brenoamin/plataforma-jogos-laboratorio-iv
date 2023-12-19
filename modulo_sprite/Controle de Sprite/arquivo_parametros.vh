`ifndef ARQUIVO_PARAMETROS_VH
`define ARQUIVO_PARAMETROS_VH

// module count_px_clk
   parameter [1:0] state_idle  = 2'b00;
   parameter [1:0] state_counting_pixel  = 2'b01;
   parameter [1:0] state_counting_640 = 2'b10;


// module sprits_main
   parameter [5:0] id_sprite_0  = 6'b000000;
   parameter [5:0] id_sprite_1  = 6'b000001;
   parameter [5:0] id_sprite_2  = 6'b000010;
   parameter [5:0] id_sprite_3  = 6'b000011;
   parameter [5:0] id_sprite_4  = 6'b000100;
   parameter [5:0] id_sprite_5  = 6'b000101;
   parameter [5:0] id_sprite_6  = 6'b000110;
   parameter [5:0] id_sprite_7  = 6'b000111;
   parameter [5:0] id_sprite_8  = 6'b001000;
   parameter [5:0] id_sprite_9  = 6'b001001;
   parameter [5:0] id_sprite_10 = 6'b001010;
   parameter [5:0] id_sprite_11 = 6'b001011;
   parameter [5:0] id_sprite_12 = 6'b001100;
   parameter [5:0] id_sprite_13 = 6'b001101;
   parameter [5:0] id_sprite_14 = 6'b001110;
   parameter [5:0] id_sprite_15 = 6'b001111;
   parameter [5:0] id_sprite_16 = 6'b010000;
   parameter [5:0] id_sprite_17 = 6'b010001;
   parameter [5:0] id_sprite_18 = 6'b010010;
   parameter [5:0] id_sprite_19 = 6'b010011;
   parameter [5:0] id_sprite_20 = 6'b010100;
   parameter [5:0] id_sprite_21 = 6'b010101;
   parameter [5:0] id_sprite_22 = 6'b010110;
   parameter [5:0] id_sprite_23 = 6'b010111;
   parameter [5:0] id_sprite_24 = 6'b011000;
   parameter [5:0] id_sprite_25 = 6'b011001;
   parameter [5:0] id_sprite_26 = 6'b011010;
   parameter [5:0] id_sprite_27 = 6'b011011;
   parameter [5:0] id_sprite_28 = 6'b011100;
   parameter [5:0] id_sprite_29 = 6'b011101;
   parameter [5:0] id_sprite_30 = 6'b011110;
   parameter [5:0] id_sprite_31 = 6'b011111;
   parameter [5:0] no_id_sprite = 6'b111111; //63


// module sprits_finder_position
   //parameter [5:0] state_idle = 6'b000000;
   parameter [1:0] state_inicio = 2'b00;
   parameter [1:0] state_comparacao_perimetro = 2'b01;
   parameter [1:0] state_layers_prioritaria = 2'b10;
   parameter [1:0] state_controller_memory = 2'b11;


`endif
