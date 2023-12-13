//`timescale 1ns/1ns

module DecodeEX_test;

  reg clk;
  reg reset;
  reg [31:0] instruction;
  reg [31:0] pcounter;
  reg [3:0] Rflags;
  wire [4:0] R, Rd, Rs, Rb;
  wire [31:0] pc_next;
  wire [3:0] ula_op;
  wire [26:0] imm;
  wire enableLW;
  wire enableSW;

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

  DecodeEX dut (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .pcounter(pcounter),
    .Rflags(Rflags),
    .pc_next(pc_next),
    .ula_op(ula_op),
    .imm(imm),
    .enableLW(enableLW),
    .enableSW(enableSW),
    .R(R),
    .Rd(Rd),
    .Rs(Rs),
    .Rb(Rb)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1;
    #10 reset = 0;
  end

// Teste 1: LW
initial begin
  instruction = 32'b11110000111100001111000011110000;
  #5;
  #5;
  $display("Teste LW: Rd=%b, imm=%b, instruction=%b", Rd, imm, instruction);
end

// Teste 2: ADD
initial begin
  instruction = {INST_ADD, 5'b00001, 5'b00010, 16'b0000000000000001};
  #20;
  $display("Teste ADD: pc_next=%h, ula_op=%h, imm=%h, instruction=%b", pc_next, ula_op, imm, instruction);
end

// Teste 3: AND
initial begin
  instruction = {INST_AND, 5'b00001, 5'b00010, 16'b1111111111111111};
  #5;
  $display("Teste AND: pc_next=%h, ula_op=%h, imm=%h", pc_next, ula_op, imm);
end

// Teste 4: JR
initial begin
  instruction = {INST_JR, 5'b00001, 5'b00000, 16'b0000000000000000};
  #20;
  $display("Teste JR: pc_next=%h, ula_op=%h, imm=%h", pc_next, ula_op, imm);
end

// Teste 5: JPC
initial begin
  instruction = {INST_JPC, 5'b00000, 5'b00000, 16'b0000000000000010};
  #20;
  $display("Teste JPC: pc_next=%h, ula_op=%h, imm=%h", pc_next, ula_op, imm);
end


  initial #100 $finish;

endmodule

