module ALU(result, a, b, Imm, OPC, reset);
  input [31:0] a;
  input [31:0] b;
  input [31:0] Imm;
  input [5:0] OPC;
  input reset;
  output [31:0] result;
  reg [31:0] result;
  integer i;
// output zero


always @*
begin
    if(reset == 1)
        result = 0;
    else begin
        case(OPC)
        0: ;//NOP
        1: result = a + b; //ADD
        2: result = a - b; // SUB
        3: result = b + Imm; //Store
        4: result = a + Imm; //Load
        5: ; //Move
        6: result = a - b;// SGE
        7: result = b - a;// SLE
        8: result = b - a;// SGT
        9: result = a - b;// SLT
        10: result = a - b;// SQE
        11: result = a - b;// SNE
        12: result = a & b;// AND
        13: result = a | b;// OR
        14: result = a ^ b;// XOR
        15: result = ~a;// NOT
        16: ;//MOVEI
        17: result = a << Imm;// SLI
        18: result = a >> Imm;// SRI
        19: result = a + Imm; //ADDI
        20: result = a - Imm; // SUBI
        23: begin
        FloatingPointAdder.FPAdder(a, b, result);
        /*$display("\nFAdd Result in ALU:");
        for (i = 31; i >= 0; i=i-1)
            $write(result[i]);*/
        end
        24: FloatingPointMultiplier.FPMultiplier(a, b, result);
        default:result = a + b;
        endcase
    end
end
//assign zero = (result==16'd0) ? 1'b1: 1'b0;

endmodule
