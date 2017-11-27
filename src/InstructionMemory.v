module InstructionMemory (DOut, AddrIn, reset);
  input reset;
  input [31:0] AddrIn;
  output [31:0] DOut;

  reg [31:0] MemoryA [31:0];
  reg [31:0] DOut;


  initial
  begin
    $readmemb("instruction_mem.txt", MemoryA, 0, 22);
  end

  always @*
    begin
        if(reset == 1)
            DOut = 0;//32'hffffffff;
        else
            DOut = MemoryA[AddrIn];
    end

endmodule
