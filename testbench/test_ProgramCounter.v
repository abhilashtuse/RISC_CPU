module test_ProgramCounter;
reg clk;
reg [31:0] PcIn;
wire [31:0] PcOut, PcNext;

ProgramCounter PC (.PcOut(PcOut),.PcNext(PcNext), .clk(clk), .PcIn(PcIn));


initial
begin
clk = 1;
forever #5 clk= !clk;
end

initial
begin
PcIn=0;
#10 PcIn=1;
#10 PcIn=2;
#10 PcIn=4;
#10 PcIn=8;
#10;$finish;

end
initial begin
    $dumpfile("test_Program_Counter.vcd");
    $dumpvars;
end
endmodule
