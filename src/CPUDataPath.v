//`timescale 1ns / 1ps
module CPUDataPath(clk, reset);
    input clk, reset;

    wire [31:0] PcOut, PcNext, PcIn, DOut1, DOut2, IR, Reg1, Reg2, AOut, D5, D7, sOut32, Q13;
    wire RF_WE, DM_WE;
    reg [31:0] Din, Q2, Q3, Q4, Q7, Q8, Q12;
    reg [15:0] Imm;
    reg [5:0] OPC, Q1, Q6;
    reg [4:0] RS1, RS2, RD, Q5, Q9, Q14;
    parameter delay = 1;

    ProgramCounter pc (.PcOut(PcOut), .PcNext(PcNext), .clk(clk), .PcIn(PcIn), .reset(reset));
    InstructionMemory im (.DOut(IR), .AddrIn(PcOut), .clk(clk), .reset(reset));
    SignExtend se(.sOut32(sOut32),.sIn16(Imm), .reset(reset));
    RegisterFile rf(.DOut1(Reg1),.DOut2(Reg2), .AddrIn1(RS1),
    	          .AddrIn2(RS2),.AddrIn3(Q14),.Din(Q13), .WE(WE), .clk(clk), .reset(reset));
    ALU alu(.result(AOut), .a(Q2), .b(Q3), .Imm(Q4), .alu_control(Q1), .reset(reset));
    DataMemory dm(.DOut(), .AddrIn(Q8), .Din(Q7), .WE(WE), .reset(reset));
    ControlUnit cu(.RF_WE(RF_WE), .DM_WE(DM_WE), .Q13(Q13), .Q6(Q6), .Q8(Q8), .reset(reset), .clk(clk));

    always @(posedge clk or reset)
        begin
            if(reset == 1) begin
            //RF stage
                OPC <= 0;
                RS1 <= 0;
                RS2 <= 0;
                RD <= 0;
                Imm <= 0;

            //ALU stage
                Q1 <= 0;
                Q2 <= 0;
                Q3 <= 0;
                Q4 <= 0;
                Q5 <= 0;

            //DM stage
                Q6 <= 0;
                Q7 <= 0;
                Q8 <= 0;
                Q9 <= 0;

            //WB stage
                Q14 <= 0;

            end
            if(reset == 0) begin
            //RF stage
                OPC <= IR [31:26];
                RS1 <= IR [25:21];
                RS2 <= IR [20:16];
                RD <= IR [15:11];
                Imm <= IR [15:0];

            //ALU stage
                Q1 <= OPC;
                Q2 <= Reg1;
                Q3 <= Reg2;
                Q4 <= sOut32;
                Q5 <= RD;

            //DM stage
                Q6 <= Q1;
                Q7 <= Q2;
                Q8 <= AOut;
                Q9 <= Q5;

            //WB stage
                Q14 <= Q9;
                Q12 <= Q8;
            end
        end
endmodule
