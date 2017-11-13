module DataMemory (DOut, AddrIn, Din, WE, reset);
  input [31:0] AddrIn;
  input [31:0] Din;
  input WE, reset;
  output [31:0] DOut;

  reg [31:0] DataMemory [31:0]; // to be confirmed
  reg [31:0] DOut;

  always @*
    begin
    if(reset == 1)
        DOut = 0;
    else if(WE==1)
        DataMemory[AddrIn] = Din;
    else
        DOut = DataMemory[AddrIn];
    end

endmodule
