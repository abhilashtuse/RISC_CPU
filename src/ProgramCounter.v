module ProgramCounter(PcOut, PcBra, clk, PcIn, reset, select);
  input clk, reset, select;
  input [31:0] PcBra;
  output [31:0] PcOut, PcIn;
  reg [31:0] PcOut, PcIn;

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
        if(select)
            PcIn <= PcBra;
        else
            PcIn <= PcIn + 1;
    end
  end
endmodule
