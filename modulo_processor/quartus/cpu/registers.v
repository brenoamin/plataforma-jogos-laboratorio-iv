module registers(
    input wire [31:0] data, instr,
    input wire [4:0] addr1, addr2,
    input wire enable_write, enable_read,
    output reg [31:0] data_out1, data_out2
  );

  reg[31:0] regs[31:0];

  localparam LW = 0;
  localparam SW = 1;
  localparam MOV = 2;

  localparam ADD = 3;
  localparam SUB = 4;
  localparam MUL = 5;
  localparam DIV = 6;

  localparam AND = 7;
  localparam OR = 8;
  localparam SHL = 9;
  localparam SHR = 10;
  localparam CMP = 11;
  localparam NOT = 12;

  always @(*)
  begin
    if (enable_write)
    begin
      case(instr[31:27])
        LW:
        begin
          regs[instr[26:22]] = data;
        end
        MOV:
        begin
          regs[instr[26:22]] = regs[instr[4:0]];
        end
        ADD, SUB, MUL, DIV, AND, OR, SHL, SHR, NOT:
        begin
          regs[instr[26:22]] = data;
        end
        default:
        begin
        end
      endcase
    end
    else if (enable_read)
    begin
      data_out1 = regs[addr1];
      data_out2 = regs[addr2];
    end
    else
    begin
      data_out1 = 'hx;
      data_out2 = 'hx;
    end
  end
endmodule
