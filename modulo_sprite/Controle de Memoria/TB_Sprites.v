////UNIVERSIDADE FEDERAL DA BAHIA
////CÓDIGO REFERENTE A FINS AVALIATIVOS NA DISCIPLINA DE LABIV
////ALUNO: JOÃO RIOS

`timescale 1ps / 1ps

module TB_Sprites;

  // Parâmetros
  parameter WORD_SIZE = 24;
  parameter MEM_DEPTH = 256;
  parameter INITIAL_WORDS = 10; // Número de palavras iniciais a serem visualizadas
  parameter Tam_Mem = 256;
  
// wire [7:0] Saida_R;
// wire [7:0] Saida_G;
// wire [7:0] Saida_B;
  // Entradas
  wire [4:0] sprite_id;
  reg clock,rst;
//  
//////  reg wren,rden;
//wire  [4:0] sprite_layer;
//
//////	reg [7:0] data;
//wire [3:0]anchor_x; //LINHA DO PIXEL
//wire [3:0]anchor_y;
//  // Saídas
  wire [23:0] q;
// wire [WORD_SIZE-1:0] sprite_data_out;
  // Instância do módulo de memória ROM
//  MemoriaSprites uut (
//    .address(address),
//    .clock(clock),
//    .q(q)
//  );
//  Memoria_onchip uut (
//    .address(address),
//    .clock(clock),
//    .q(q)
//  );

// Processa_Sprite sprtb (
// 
//        .sprite_layer(sprite_layer),
//		  .sprite_id(Sprite_id),
//        .clock(clock),
//		  .anchor_x(anchor_x),
//		  .anchor_y(anchor_y),
//        .addr(q)
//      );
		
 TesteMemoria4 sprtb (
 
      
        .clock(clock),
		  .pixel(q),
		  .rst(rst)
//		  .Sprite_id(Sprite_id ) ,
//		  .anchor_x( anchor_x),
//		  .anchor_y( anchor_y), 
//		  .sprite_layer( sprite_layer)

      );
		
  // Gerador de clock
  initial begin
    clock = 0;
    forever #1 clock = ~clock;
  end

  // Teste: visualizar as palavras iniciais
  initial begin
    $monitor("Time=%0t    q=%h  ", $time , q );
//	    $monitor("Time=%0t sprite_layer=%h  Sprite_id=%h q=%h anchor_x=%h anchor_y ", $time,anchor_y,sprite_layer,anchor_x , Sprite_id, q );
rst = 1;
#1
rst = 0;
//			sprite_layer = 3;
//		  Sprite_id = 1;
//		  anchor_x =  5;
//		  anchor_y=  7;
//	
//	 #3; // Espera alguns ciclos entre as leituras
//		
//     sprite_layer = 6;
//		  Sprite_id = 5;
//		  anchor_x =  7;
//		  anchor_y=  8;
//	
////      #4; 
//	
//	 #3; // Espera alguns ciclos entre as leituras
//		
//     sprite_layer = 2;
//		  Sprite_id = 0;
//		  anchor_x =  4;
//		  anchor_y=  6;
//	
////      #4; 
//	//      #4; 
////	
//	 #3; // Espera alguns ciclos entre as leituras
//		
//     sprite_layer = 1;
//		  Sprite_id = 20;
//		  anchor_x =  0;
//		  anchor_y=  0;
//	
//		 #3; // Espera alguns ciclos entre as leituras
//		
//     sprite_layer = 0;
//		  Sprite_id = 0;
//		  anchor_x =  1;
//		  anchor_y=  1;
//	
////   
//		 #3; // Espera alguns ciclos entre as leituras
//		
//     sprite_layer = 11;
//		  Sprite_id = 20;
//		  anchor_x =  0;
//		  anchor_y=  0;
//	
////   
//    // Realiza a leitura das palavras iniciais
//    repeat(INITIAL_WORDS) begin
//       // Espera alguns ciclos entre as leituras
//		
//     sprite_layer = sprite_layer - 1;
//		  Sprite_id = Sprite_id + 1;
//		  anchor_x =  anchor_x + 1;
//		  anchor_y=  anchor_y + 1;
//	#3;
//      
//    end
 
    // Termina a simulação
    #1500;
    $finish;
  end

endmodule
