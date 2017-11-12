//`timescale 1ns / 1ps
module CPU_DataPath(clk, reset);
    input clk, reset;

    wire [31:0] PcOut, PcNext, PcIn, DOut1, DOut2, Imm, IR, Reg1, Reg2, AOut, D5, D7;
    wire WE;
    reg [31:0] A, B, Din;
    reg [5:0] OPC;
    reg [4:0] RS1, RS2, RD, Q5, Q7;
    parameter delay = 1;

    ProgramCounter pc (.PcOut(PcOut), .PcNext(PcNext), .clk(clk), .PcIn(PcIn), .reset(reset));
    InstructionMemory im (.DOut(IR), .AddrIn(PcOut));
    RegisterFile rf(.DOut1(Reg1),.DOut2(Reg2), .AddrIn1(RS1),
    	          .AddrIn2(RS2),.AddrIn3(Q7),.Din(Din), .WE(WE));
    ALU alu(.result(AOut), .a(A), .b(B), .Imm(Imm), .alu_control(OPC));


//WE needs to be passsed from control_unit, it should be 0 in RF stage and 1 in WB stage..
    always @ (posedge clk)
        begin
            OPC <= IR [31:26];
            RS1 <= IR [25:21];
            RS2 <= IR [20:16];
            RD <= IR [15:11];
            A <= Reg1;
            B <= Reg2;
            Din <= AOut;
            Q5 <= RD;
            Q7 <= Q5;
        end
endmodule
