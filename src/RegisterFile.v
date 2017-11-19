module RegisterFile (DOut1,DOut2, AddrIn1,AddrIn2,AddrIn3,Din, WE, clk, reset);
  input [4:0] AddrIn1,AddrIn2,AddrIn3;
  input [31:0] Din;
  input WE, clk, reset;
  output [31:0] DOut1,DOut2;

  reg [31:0] RegisterMemory [31:0]; // 2^5 becoz address is of 5 bits
  reg [31:0] DOut1, DOut2;

  initial
  begin
    DOut1 = 0;
    DOut2 = 0;
    $readmemb("reg_file.txt", RegisterMemory, 0, 10);
  end

  always @(posedge clk or posedge reset)
    begin
        if(reset == 1) begin
            DOut1 = 0;
            DOut2 = 0;
        end
        if(WE == 1 && reset == 0) begin
            RegisterMemory[AddrIn3] = Din;
            //$display("Written :", RegisterMemory[AddrIn3]);
        end

    end

  always @(negedge clk or posedge reset)
    begin
        if(reset==0) begin
            DOut1 = RegisterMemory[AddrIn1];
            DOut2 = RegisterMemory[AddrIn2];
        end
    end
endmodule
