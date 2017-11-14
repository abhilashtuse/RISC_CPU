module ALU(result, a, b, Imm, alu_control, reset);
  input [31:0] a;
  input [31:0] b;
  input [31:0] Imm;
  input [5:0] alu_control;
  input reset;
  output [31:0] result;
  reg [31:0] result;
// output zero


always @*
begin
    if(reset == 1)
        result = 0;
    else begin
        case(alu_control)
        0: ;//NOP
        1: result = a + b; //ADD
        2: result = a - b; // SUB
        3: result = b + Imm; //Store
        //4: result = a + Imm; //Load
        //5: ; //Move
        //3'b011: result = a<<b;
        //3'b100: result = a>>b;
        //3'b101: result = a & b;
        //3'b110: result = a | b;
        //3'b111: begin if (a<b) result = 16'd1;
        //  else result = 16'd0;
        //end
        default:result = a + b;
        endcase
    end
end
//assign zero = (result==16'd0) ? 1'b1: 1'b0;

endmodule
