module Processor #(
	parameter PROGRAM_FILE_PATH = "program.bin",
	parameter DATA_WIDTH = 32
)(
	input wire clock,
	input wire reset,
	input wire [DATA_WIDTH-1:0] instruction,
	
	// Outputs to background and sprite modules
	output reg [9:0] background_x,
	output reg [9:0] background_y,
	output reg [9:0] sprite_x,
	output reg [9:0] sprite_y,
	output reg [4:0] sprite_id
);
	
	// Architecture constants
	localparam integer PROGRAM_COUNTER_ADDRESS_WIDTH = 20;
	localparam integer PROGRAM_COUNTER_SELECTOR_SIZE = 2;
	localparam integer MEMORY_ADDRESS_WIDTH = 15;
	
	// Programmable functions
	localparam FUNCTION_SPRITE_LEVEL = 5'b00001;
	localparam FUNCTION_SPRITE_POS = 5'b00010;
	localparam FUNCTION_SPRITE_COLLISION_BG = 5'b00011;
	localparam FUNCTION_SPRITE_COLLISION_SP = 5'b00100;
	localparam FUNCTION_PUT_IMAGE = 5'b00101;
	localparam FUNCTION_WAIT_VSYNC = 5'b00110;
	
	// Internal wires
	wire [MEMORY_ADDRESS_WIDTH-1:0] fetch_address;
	wire [DATA_WIDTH-1:0] fetch_instruction;
	wire [DATA_WIDTH-1:0] fetched_instruction;
	wire [MEMORY_ADDRESS_WIDTH-1:0] fetched_address;
	wire [DATA_WIDTH-1:0] immediate;
	
	// Decode wires
	wire [4:0] instruction_code;
	wire [4:0] R, Rd, Rs, Rb, M;
	
	// Internal registers
	reg [2:0] selector = 0;
	
	// ProgramCounter (PC) component
	ProgramCounter #(
		.WORD_SIZE(MEMORY_ADDRESS_WIDTH)
	) ProgramCounter_instance(
		.clock(clock),
		.reset(reset),
		.instruction(instruction),
		.selector(selector),
		.out(fetch_address)
	);
	
	// Memory component
	Memory #(
		.ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.INITIAL_MEMORY_DATA_PATH(PROGRAM_FILE_PATH)
	) Memory_instance(
		.write(1'b0),
		.read(1'b1),
		.address(fetch_address),
		.out(fetch_instruction)
	);

	// Fetch component
	Fetch #(
		.ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH),
		.DATA_WIDTH(DATA_WIDTH)
	) Fetch_instance(
		.clock(clock),
		.reset(reset),
		.fetch_address(fetch_address),
		.fetch_instruction(fetch_instruction),
		.fetched_address(fetched_address),
		.fetched_instruction(fetched_instruction)
	);

	// Extensor component
	Extensor #(
		.DATA_WIDTH(DATA_WIDTH)
	) Extensor_instance(
		.instruction(fetched_instruction),
		.immediate(immediate)
	);
	
	// Decode component
	Decode Decode_instance(
		.clock(clock),
		.reset(reset),
		.instruction_set(fetched_instruction),
		.instruction_code(instruction_code),
		.immediate(immediate),
		.R(Rd1),
		.Rd(Rd),
		.Rs(Rs),
		.Rb(Rb),
		.M(M)		
	);

endmodule
