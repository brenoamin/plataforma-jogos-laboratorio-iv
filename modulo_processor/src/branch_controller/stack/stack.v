module stack #(
    parameter integer WIDTH = 8,      //! Stack width - num of bits
    parameter integer DEPTH = 2       //! Pointer depth - num of positions
  ) (
    input wire clk, rst,                  //! Clock input pin
    output reg full,                 //! Full output pin
    output reg empty,                //! Empty output pin
    output reg [WIDTH-1:0] data_out,  //! Data out
    input wire [WIDTH-1:0] data_in,   //! Data in
    input wire pop,                   //! Pop pin (read)
    input wire push                   //! Push pin (write)
  );

  reg [DEPTH - 1:0] pointer;       //! Stack pointer
  reg [WIDTH-1:0] lifo [0:DEPTH - 1]; //! Last In First Out queue

  always @(posedge clk, posedge rst)
  begin : STACK
    if (rst)
    begin
      pointer <= 0;
      full <= 0;
      empty <= 0;
    end
    else
    begin
      if(push && pointer != DEPTH)
      begin
        lifo[pointer] <= data_in;
        pointer <= pointer + 1;
        empty <= 0;
      end
      else if(push && pointer == DEPTH)
      begin
        full <= 1;
      end

      else if(pop && pointer != 0)
      begin
        data_out <= lifo[pointer-1];
        pointer <= pointer - 1;
        full <= 0;
      end
      else if(pop && pointer == 0)
      begin
        empty <= 1;
      end
    end
  end

endmodule
