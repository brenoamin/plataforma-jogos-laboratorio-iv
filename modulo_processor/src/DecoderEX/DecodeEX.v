
module DecodeEX (
    input wire clk,
    input wire reset,
    input wire [31:0] instruction,
    input wire [31:0] pcounter,
    input wire [3:0] Rflags,

    output reg [31:0] pc_next,
    output reg [3:0] ula_op,	
    output reg [26:0] imm,
    output reg enableLW,
    output reg enableSW,
    output reg [4:0] R, Rd, Rs, Rb
);
    // Instructions arameters 
    parameter INST_LW   = 5'b00000;
    parameter INST_SW   = 5'b00001;
    parameter INST_MOV  = 5'b00010;
    parameter INST_ADD  = 5'b00011;
    parameter INST_SUB  = 5'b00100;
    parameter INST_MUL  = 5'b00101;
    parameter INST_DIV  = 5'b00110;
    parameter INST_AND  = 5'b00111;
    parameter INST_OR   = 5'b01000;
    parameter INST_SHL  = 5'b01001;
    parameter INST_SHR  = 5'b01010;
    parameter INST_CMP  = 5'b01011;
    parameter INST_NOT  = 5'b01100;
    parameter INST_JR   = 5'b01101;
    parameter INST_JPC  = 5'b01110;
    parameter INST_BRFL = 5'b01111;
    parameter INST_CALL = 5'b10000;
    parameter INST_RET  = 5'b10001;
    parameter INST_NOP  = 5'b10010;

    reg [4:0] opcode;
    reg [6:0] M;

    always @(posedge clk) begin
        if (reset) begin
            opcode <= 4'b0;
            Rd <= 5'b0;
            Rs <= 5'b0;
            Rb <= 5'b0;
            imm <= 15'b0;
	    M <= 6'b0;
        end else begin
            opcode <= instruction[31:27];

            case (opcode)
		// Data Transfer operations
                INST_LW: begin
		    Rd <= instruction[26:22];
		    imm <= instruction[21:6];
		    Rb <= instruction[4:0];
		    enableLW <= 1;
                end
                INST_SW: begin
		    Rs <= instruction[26:22];
		    imm <= instruction[21:6];
		    Rb <= instruction[4:0];
		    enableSW <= 1;
                end
                INST_MOV: begin
		    Rd <= instruction[26:22];
		    Rs <= instruction[4:0];
		    // mov...?
                end

		// Aritmetic operations
		INST_ADD: begin 
		    //result <= instruction[26:22]; n existe, result == Rd
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_ADD[3:0];
		end
		INST_SUB: begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_SUB[3:0];
		end
		INST_MUL: begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_MUL[3:0];
		end
		INST_DIV: begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_DIV[3:0];
		end

		// Logic operations
		INST_AND: begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_AND[3:0];
		end
		INST_OR:  begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_OR[3:0];
		end
		INST_SHL: begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_SHL[3:0];
		end
		INST_SHR: begin
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_SHR[3:0];
		end
		INST_CMP: begin 
		    Rd <= instruction[21:17];
		    Rs <= instruction[16:12];
		    ula_op <= INST_CMP[3:0];
		end
		INST_NOT: begin 
		    Rd <= instruction[21:17];
		    ula_op <= INST_NOT[3:0];
		end

		// Controll transfer operations
                INST_JR: begin
		    R <= instruction[14:10];
			// Jump to R
                end
                INST_JPC: begin
		    imm <= instruction[25:0];
		    // Jump to pc + imn
                end
                INST_BRFL: begin
		    R <= instruction[14:10];
		    imm <= instruction[9:5];
		    M <= instruction[4:0];
		    // if RFlags[i]= I7[i], for all i = 1 em M7
		    // jump to R
		    // else nothing...
                end
                INST_CALL: begin
		    R <= instruction[14:10];
		    // stack up pcounter
		    // jump to R
                end                
		INST_RET: begin
		    // jump to TOP of the stack
		    // unstack
                end
                INST_NOP: begin
		    // relax
                end
                default: begin
		    // ...
                end
            endcase
        end
    end
endmodule
