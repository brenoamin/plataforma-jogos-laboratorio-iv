# include "sys/ alt_stdio .h"
# include < altera_up_avalon_video_character_buffer_with_dma .h >
# include " stdio .h"
# include "io.h"
# include " system .h"
/*
* Addresses :
* VGA ( sram ) buffer 0 x0201000
* video char control 0 x00800020
* video char buffer 0 x00802000
* */
void VGA_box (int , int , int , int , int ) ;
volatile int i , j ;
int main () {
// Initialization
alt_up_char_buffer_dev * char_buffer = NULL ;
char_buffer = alt_up_char_buffer_open_dev ("/ dev/ video_character_buffer_with_dma_0
") ;
		alt_up_char_buffer_init ( char_buffer ) ;
		alt_up_char_buffer_clear ( char_buffer ) ;
		VGA_box (0 , 0 , 320 , 240 , 0 x0000 ) ;
		int k , l ;
		char in_character ;
		printf (" Introduce characters \n") ;
		for ( k =0; k <60; k ++) {
		for ( l =0; l <80; l ++) {
		in_character = getchar () ;
		while ( in_character == 0 x0a )
		in_character = getchar () ;
		if( in_character !=0 x0a )// if not the line feed
		alt_up_char_buffer_draw ( char_buffer , in_character , l , k ) ;
		}
		}
		printf (" Terminated !\n") ;
		return 0;
		}
		// Function declarations
		void VGA_box (int x1 , int y1 , int x2 , int y2 , int pixel_color ) {
		int offset , row , col ;
		// Declare volatile pointer to pixel buffer (IO load / store instructions )
		// will be used to access these pointer locations instead of regular
		// memory loads and stores
		volatile short * pixel_buffer = ( short *) 0 x08000000 ;// VGA pixel buffer address
		// For this implementation we assume that the
		// box coordinates are valid
		for ( row = y1 ; row <= y2 ; row ++) {
		col = x1 ;
		while ( col <= x2 ) {
		// The lines start at multiples of 2^9 (0;512;1024)
		offset = ( row << 9) + col ;
		// Compute halfword address and set the pixel
		*( pixel_buffer + offset ) = pixel_color ;
		++ col ;
		}
		}
		}
