module RegisterFile (DOut1,DOut2, Ain1,Ain2,Ain3,Din, WE, clk, reset);
  input [4:0] Ain1,Ain2,Ain3;
  input [31:0] Din;
  input WE, clk, reset;
  output [31:0] DOut1,DOut2;

  reg [31:0] RegisterMemory [31:0]; // 2^5 becoz address is of 5 bits
  reg [31:0] DOut1, DOut2;

  initial
  begin
    DOut1 = 0;
    DOut2 = 0;
    $readmemb("reg_file.txt", RegisterMemory, 0, 12);
  end

  always @(posedge clk or posedge reset)
    begin
        if(reset == 1) begin
            DOut1 = 0;
            DOut2 = 0;
        end
        if(WE == 1 && reset == 0) begin
            RegisterMemory[Ain3] = Din;
            //$display("Written :", RegisterMemory[Ain3]);
        end

    end

  always @(negedge clk or posedge reset)
    begin
        if(reset==0) begin
            DOut1 = RegisterMemory[Ain1];
            DOut2 = RegisterMemory[Ain2];
        end
    end
endmodule
