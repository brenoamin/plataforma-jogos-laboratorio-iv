module Extensor #(
	parameter integer DATA_WIDTH = 32
)(
	input wire [DATA_WIDTH-1:0] instruction,
	output reg [DATA_WIDTH-1:0] immediate
);

	localparam INSTRUCTION_DATA_TRANSFER = 5'b00000;
	localparam INSTRUCTION_ARITHMETIC_AND_LOGICAL = 5'b00001;
	localparam INSTRUCTION_CONTROL_TRANSFER = 5'b00010;
	
	reg [1:0] instruction_type;
	
	wire [15:0] immediate_data_transfer;
	wire [11:0] immediate_arithmetic_logical;
	wire [26:0] immediate_control_transfer;
	
	assign immediate_data_transfer = instruction[21:6];
	assign immediate_arithmetic_logical = instruction[11:0];
	assign immediate_control_transfer = instruction[26:0];
	
	always @(*) begin : EXT32
		case (instruction_type)
			INSTRUCTION_DATA_TRANSFER:
				immediate = {{16{immediate_data_transfer[15]}}, immediate_data_transfer};
				
			INSTRUCTION_ARITHMETIC_AND_LOGICAL:
				immediate = {{20{immediate_arithmetic_logical[11]}}, immediate_arithmetic_logical};
				
			INSTRUCTION_CONTROL_TRANSFER:
				immediate = {{5{immediate_control_transfer[26]}}, immediate_control_transfer};

			default:
				immediate = instruction;
		endcase
	end
	
	always @(*) begin : GET_INSTRUCTION_TYPE
		case (instruction[31:27])
			 0,2:
			  instruction_type = INSTRUCTION_DATA_TRANSFER;
			  
			3,12:
			  instruction_type = INSTRUCTION_ARITHMETIC_AND_LOGICAL;
			  
			13,18:
			  instruction_type = INSTRUCTION_CONTROL_TRANSFER;
			  
			default:
				instruction_type = 0;
		endcase
	end
endmodule