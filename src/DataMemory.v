module DataMemory (DOut, AddrIn, Din, WE, reset, clk);
  input [31:0] AddrIn;
  input [31:0] Din;
  input WE, reset, clk;
  output [31:0] DOut;

  reg [31:0] DataMemory [31:0]; // to be confirmed
  reg [31:0] DOut;

  initial
  begin
    DOut = 0;
    $readmemb("data_file.txt", DataMemory, 0, 12);
  end

  always @(posedge clk or posedge reset)
    begin
    if(reset == 1)
        DOut = 0;
    else if(WE==1 && reset == 0)
        DataMemory[AddrIn] = Din;
    end

    always @(negedge clk or posedge reset)
      begin
          if(reset == 0 ) begin
              DOut = DataMemory[AddrIn];
          end
      end
endmodule
