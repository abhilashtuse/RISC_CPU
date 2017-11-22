module CPUDataPath(clk, reset);
    input clk, reset;

    wire [31:0] PcOut, PcIn, DOut1, DOut2, IR, Reg1, Reg2, AOut, D5, D7, Imm_SE, RS2_SE, DMemOut;
    wire RF_WE, DM_WE;
    reg [31:0] Din, Q0, Q2, Q3, Q4, Q7, Q8, Q11, Q12, Q13, RFDin, PcBra, JImm;
    reg [15:0] Imm;
    reg [5:0] OPC, Q1, Q6, Q10;
    reg [4:0] RS1, RS2, RD, Q5, Q9, Q14;
    reg sign_bit, select;
    parameter delay = 1;

    ProgramCounter pc (.PcOut(PcOut), .PcBra(PcBra), .clk(clk), .PcIn(PcIn), .reset(reset) , .select(select));
    InstructionMemory im (.DOut(IR), .AddrIn(PcOut), .clk(clk), .reset(reset));
    SignExtend16 se16(.sOut16(Imm_SE),.sIn16(Imm), .reset(reset));
    SignExtend27 se27(.sOut27(RS2_SE), .sIn5(RS2), .reset(reset)); //branch instruction
    RegisterFile rf(.DOut1(Reg1),.DOut2(Reg2), .AddrIn1(RS1),
    	          .AddrIn2(RS2),.AddrIn3(Q14),.Din(RFDin), .WE(RF_WE), .clk(clk), .reset(reset));
    ALU alu(.result(AOut), .a(Q2), .b(Q3), .Imm(Q4), .alu_control(Q1), .reset(reset));
    DataMemory dm(.DOut(DMemOut), .AddrIn(Q8), .Din(Q7), .WE(DM_WE), .reset(reset), .clk(clk));
    ControlUnit cu(.RF_WE(RF_WE), .DM_WE(DM_WE),.Q6(Q6), .Q10(Q10), .reset(reset), .clk(clk));

    always @*
    begin
        sign_bit = Q8[31:31];
        //$display("IR_OPC",IR [31:26], " OPC:",OPC);
        if(OPC == 21 && Reg1 == RS2_SE) begin
                select = 1;
                PcBra = Q0 + Imm_SE;
            end
        else
            select = 0;
        if(OPC == 22) begin
            select = 1;
            PcBra = JImm;
        end
    end
    always @(posedge clk or reset)
        begin
            if(reset == 1) begin
            //RF stage
                OPC <= 0;
                RS1 <= 0;
                RS2 <= 0;
                RD <= 0;
                Imm <= 0;
                RFDin <= 0;

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
                Q10 <= 0;
                Q11 <= 0;
                Q12 <= 0;
                Q13 <= 0;
                Q14 <= 0;
            end
            if(reset == 0) begin
            //RF stage
                OPC <= IR [31:26];//$display("opc",OPC);
                RS1 <= IR [25:21];
                RS2 <= IR [20:16];
                RD <= IR [15:11];
                Imm <= IR [15:0];
                JImm <= {{6{1'b0}}, IR [25:0]};
                Q0 <= PcOut;

            //ALU stage
                Q1 <= OPC;//$display("Q1",Q1);
                Q2 <= Reg1;
                //$display(2);
                Q3 <= Reg2;
                Q4 <= Imm_SE;
                //Q5 <= RD;

                if(OPC == 4 || OPC == 5 || OPC == 15 ||
                    OPC == 17 || OPC == 18 || OPC == 19 ||
                    OPC == 20 || OPC == 16)

                    Q5 <= RS2;

                else
                    Q5 <= RD;


            //DM stage
                Q6 <= Q1;//$display("Q6",Q6);
                if(Q1 == 16)
                    Q7 <= Q4;
                else
                    Q7 <= Q2;
                Q8 <= AOut;
                Q9 <= Q5;

            //WB stage
                Q10 <= Q6;//$display("Q10",Q10);
                //Q11 <= Q7;
                //Q12 <= DMemOut;
                Q13 <= Q8;
                Q14 <= Q9;

                case(Q6)
                    1: RFDin <= Q8; //ADD
                    2: RFDin <= Q8; // SUB
                    4: RFDin <= DMemOut; // Load
                    5: RFDin <= Q7; // Move
                    6,7: begin // SGE/SLE
                            //$display(sign_bit);
                            if(sign_bit)
                                RFDin <= 0;
                            else
                                RFDin <= 1;
                        end
                    8,9: begin //SGT/SLT
                            //$display(sign_bit);
                            if(sign_bit)
                                RFDin <= 1;
                            else
                                RFDin <= 0;
                        end
                    10: begin //SEQ
                            //$display("Equal:",Q8);
                            if(Q8==0)
                                RFDin <= 1;
                            else
                                RFDin <= 0;
                        end
                    11: begin //SNE
                            //$display("Not Equal:",Q8);
                            if(Q8==0)
                                RFDin <= 0;
                            else
                                RFDin <= 1;
                        end
                    12,13,14,15: begin
                                    RFDin <= Q8;//AND/OR/XOR
                                    // $display(Q8);
                                end
                    16: RFDin <= Q7;//MOVEI
                    17,18,19,20: begin
                                RFDin <= Q8; //SLI/SRI/ADDI/SUBI
                            end
                    21,22:;// bra/Jump
                endcase

            end
        end
endmodule
