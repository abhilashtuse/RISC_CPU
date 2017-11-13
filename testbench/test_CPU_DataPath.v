//`timescale 1ns / 1ps
module test_CPU_DataPath;
    reg clk, reset;

    CPU_DataPath cpu (.clk(clk), .reset(reset));

    initial
        begin
            clk = 1;
            forever #1 clk= !clk;
        end

    initial
        begin
            /*  reset = 1;
            #2 reset = 0;
            #2;
            #2 reset = 1;
            #2; reset = 0;*/

            reset = 1;
            #2 reset = 0;
            repeat(20)
              #1;
            $finish;
        end

    initial
        begin
            $dumpfile("test_CPU_DataPath.vcd");
            $dumpvars;
        end
endmodule
