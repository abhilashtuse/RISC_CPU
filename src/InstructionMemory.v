module InstructionMemory (DOut, AddrIn);
  input [31:0] AddrIn;
  output [31:0] DOut;

  reg [31:0] MemoryA [2:0];
  reg [31:0] DOut;


  initial
  begin
    $readmemb("instruction_mem.txt", MemoryA, 0, 2);
  end

  always @*
    begin
      DOut = MemoryA[AddrIn];
    end

endmodule
