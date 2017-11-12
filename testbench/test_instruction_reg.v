module test_instruction_reg;
  wire [31:0]DOut;
  reg clk;
  reg [31:0]AddrIn;

  InstructionMemory im(.DOut(DOut), .AddrIn(AddrIn);

  initial
  begin
  clk = 1;
   forever #5 clk= !clk;
  end

  initial
  begin
  AddrIn = 0;
  #10 AddrIn = 1;
  //#10 AddrIn = 2;
  #10;
  #10; $finish;
  end
  initial begin
      $dumpfile("test_instruction_reg.vcd");
      $dumpvars;
  end

endmodule
