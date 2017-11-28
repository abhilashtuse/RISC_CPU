module DataMemory (DOut, Ain, Din, WE, reset, clk);
  input [31:0] Ain;
  input [31:0] Din;
  input WE, reset, clk;
  output [31:0] DOut;

  reg [31:0] DataMemory [205:0];
  reg [31:0] DOut;

  initial
  begin
    DOut = 0;
    $readmemb("data_file.txt", DataMemory, 0, 202);
  end

  always @(posedge clk or posedge reset)
    begin
    if(reset == 1)
        DOut = 0;
    else if(WE == 1 && reset == 0)
        DataMemory[Ain] = Din;
    end

    always @(negedge clk or posedge reset)
      begin
          if(reset == 0 && (Ain >= 0 && Ain <= 205)) begin
              DOut = DataMemory[Ain];
          end
      end
endmodule
