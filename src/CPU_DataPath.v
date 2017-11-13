//`timescale 1ns / 1ps
module CPU_DataPath(clk, reset);
    input clk, reset;

    wire [31:0] PcOut, PcNext, PcIn, DOut1, DOut2, IR, Reg1, Reg2, AOut, D5, D7, sOut32;
    wire WE;
    reg [31:0] A, B, Din, AImm, DAddIn, Q;
    reg [15:0] Imm;
    reg [5:0] OPC, Q2;
    reg [4:0] RS1, RS2, RD, Q5, Q7;
    parameter delay = 1;

    ProgramCounter pc (.PcOut(PcOut), .PcNext(PcNext), .clk(clk), .PcIn(PcIn), .reset(reset));
    InstructionMemory im (.DOut(IR), .AddrIn(PcOut), .clk(clk), .reset(reset));
    sign_extend se(.sOut32(sOut32),.sIn16(Imm), .reset(reset));
    RegisterFile rf(.DOut1(Reg1),.DOut2(Reg2), .AddrIn1(RS1),
    	          .AddrIn2(RS2),.AddrIn3(Q7),.Din(Din), .WE(WE), .clk(clk), .reset(reset));
    ALU alu(.result(AOut), .a(A), .b(B), .Imm(AImm), .alu_control(Q2), .reset(reset));
    DataMemory dm(.DOut(), .AddrIn(DAddIn), .Din(Q), .WE(WE), .reset(reset));

    always @(posedge clk or reset)
        begin
            if(reset == 1) begin
                OPC <= 0;
                RS1 <= 0;
                RS2 <= 0;
                RD <= 0;
                Q2 <= 0;
                A <= 0;
                B <= 0;
                Imm <= 0;
                AImm <= 0;
                Din <= 0;
                Q5 <= 0;
                Q7 <= 0;
                Q <= 0;
                DAddIn <= 0;
            end
            if(reset == 0) begin
                OPC <= IR [31:26];
                RS1 <= IR [25:21];
                RS2 <= IR [20:16];
                RD <= IR [15:11];
                Imm <= IR [15:0];
                Q2 <= OPC;
                A <= Reg1;
                B <= Reg2;
                AImm <= sOut32;
                Din <= AOut;
                Q5 <= RD;
                Q7 <= Q5;
                Q <= A;
                DAddIn <= AOut;
            end
        end
endmodule
