module test_fp_multiplier;
    reg clk;

    reg[31:0] a,b;
    wire[31:0] result;
    FloatingPointMultiplier fp_multiplier (.clk(clk), .a(a), .b(b), .result(result));

    initial
        begin
            clk = 1;
            forever #1 clk= !clk;
        end

    initial
        begin
            // +ve Equal case
            /*a = 32'b00111111000000000000000000000000;
            b = 32'b00111111000000000000000000000000;

            // +ve, -ve
            a = 32'b00111111000000000000000000000000;
            b = 32'b10111110111000000000000000000000;

            // -ve, +ve
            a = 32'b10111110111000000000000000000000;
            b = 32'b00111111000000000000000000000000;*/

            // -ve Equal case
            a = 32'b10111111010000000000000000000000;
            b = 32'b10111111010000000000000000000000;

            #2;$finish;
        end

    initial
        begin
            $dumpfile("test_fp_multiplier.vcd");
            $dumpvars;
        end
endmodule
