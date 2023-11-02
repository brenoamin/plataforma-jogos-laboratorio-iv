module extensor(
    input wire [31:0] instruction,
    output reg [31:0] immediate
  );

  localparam
    DATA_TRANSFER           = 5'b00000,
    ARITHMETIC_AND_LOGICAL  = 5'b00001,
    CONTROL_TRANSFER        = 5'b00010;

  wire [4:0] instruction_type;

  assign instruction_type = instruction[31:27];

  wire [15:0] immediate_dt;
  wire [11:0] immediate_al;
  wire [26:0] immediate_ct;

  assign immediate_dt = instruction[21:6];
  assign immediate_al = instruction[11:0];
  assign immediate_ct = instruction[26:0];

  always @(*)
  begin
    case (instruction_type)
      DATA_TRANSFER:
      begin
        immediate = {{16{immediate_dt[15]}}, immediate_dt};
      end

      ARITHMETIC_AND_LOGICAL:
      begin
        immediate = {{20{immediate_al[11]}}, immediate_al};
      end

      CONTROL_TRANSFER:
      begin
        immediate = {{5{immediate_ct[26]}}, immediate_ct};
      end
      default:
        immediate = instruction;
    endcase
  end
endmodule
