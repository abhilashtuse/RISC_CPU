//`include "../src/FloatingPointMultiplier.v"
module test_fp_multiplier;
    reg[31:0] a,b, result;

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

            FloatingPointMultiplier.FPMultiplier(a, b, result);

            #2;$finish;
        end

    initial
        begin
            $dumpfile("test_fp_multiplier.vcd");
            $dumpvars;
        end
endmodule
