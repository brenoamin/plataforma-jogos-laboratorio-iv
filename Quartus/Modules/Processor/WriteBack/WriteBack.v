module WriteBack #(
	parameter DATA_WIDTH = 32
)(
	input wire [DATA_WIDTH-1:0] instruction,
	input wire [DATA_WIDTH-1:0] in,
	input wire [DATA_WIDTH-1:0] memory_in,
	output reg [DATA_WIDTH-1:0] out
);
	
	// Architecture constants
	localparam INSTRUCTION_TYPE_DATA = 5'b00000;
	localparam INTRUCTION_TYPE_MEMORY_DATA = 5'b00001;
	
	// Internal registers
	reg instruction_type;
	
	always @(*) begin : WRITE_BACK_MUX_LOGIC
		case (instruction_type)
			INSTRUCTION_TYPE_DATA:
				out <= in;
			INTRUCTION_TYPE_MEMORY_DATA:
				out <= memory_in;
			default:
				out <= in;
		endcase
	end
	
	always @(*) begin : DETERMINE_INSTRUCTION_TYPE
		case (instruction[DATA_WIDTH-1:27])
			0, 1:
				instruction_type = INTRUCTION_TYPE_MEMORY_DATA;
			2, 18:
				instruction_type = INSTRUCTION_TYPE_DATA;
			default:
				instruction_type = INSTRUCTION_TYPE_DATA;
		endcase
	end

endmodule