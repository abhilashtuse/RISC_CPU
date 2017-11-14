module ProgramCounter(PcOut, PcNext, clk, PcIn, reset);
  input clk, reset;
  //input [31:0] PcIn;
  output [31:0] PcOut, PcNext, PcIn;
  reg [31:0] PcOut, PcNext, PcIn;

initial
  begin
    //PcOut = 0;
    PcIn = 0;
    //PcNext = 0;
end

always @(posedge clk or reset)
  begin
  if(reset == 1) begin
      PcOut <= 0;
      PcIn <= 0;
  end
  else if(reset==0) begin
        PcOut <= PcIn;
        PcIn <= PcIn + 1;
        //PcNext <= PcIn + 1;
    end
  end
endmodule
