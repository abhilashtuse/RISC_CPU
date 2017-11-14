module InstructionMemory (DOut, AddrIn, clk, reset);
  input reset, clk;
  input [31:0] AddrIn;
  output [31:0] DOut;

  reg [31:0] MemoryA [31:0];
  reg [31:0] DOut;


  initial
  begin
    $readmemb("instruction_mem.txt", MemoryA, 0, 2);
  end

  always @*
    begin
        if(reset == 1)
            DOut = 0;//32'hffffffff;
        else
            DOut = MemoryA[AddrIn];
    end

endmodule
