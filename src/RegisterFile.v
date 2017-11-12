module RegisterFile (DOut1,DOut2, AddrIn1,AddrIn2,AddrIn3,Din, WE);
  input [4:0] AddrIn1,AddrIn2,AddrIn3;
  input [31:0] Din;
  input WE;
  output [31:0] DOut1,DOut2;

  reg [31:0] RegisterMemory [31:0]; // 2^5 becoz address is of 5 bits
  reg [31:0] DOut1, DOut2;

  initial
  begin
    $readmemb("reg_file.txt", RegisterMemory, 0, 2);
  end

  always @*
    begin
      if(WE == 1)
        RegisterMemory[AddrIn3] <= Din;
      else
        begin
        DOut1 <= RegisterMemory[AddrIn1];
        DOut2 <= RegisterMemory[AddrIn2];
        end
    end

endmodule
