module FloatingPointMultiplier();
task FPMultiplier;
    input[31:0] a, b;
    output [31:0] result;

    integer i, shift_count, norm_count;
    reg select;
    reg[31:0] result;
    reg[7:0] delta_exp, exp1, exp2, exp1_bias, exp2_bias;
    reg[8:0] res_exp;
    reg[23:0] frac1, frac2;
    reg[47:0] frac_mul;
    reg[24:0] frac_mul_trunc;

    begin
        frac1[23] = 1;
        frac2[23] = 1;
        frac1[22:0] = a[22:0];
        frac2[22:0] = b[22:0];
        exp1 = a[30:23];
        exp1_bias = exp1 - 127;
        exp2 = b[30:23];
        exp2_bias = exp2 - 127;
        res_exp = exp1_bias + exp2_bias;
        frac_mul = frac1 * frac2;
        frac_mul_trunc[24:0] = frac_mul[47:23]; //Truncate

        if (frac_mul_trunc[24] == 0 && frac_mul_trunc[23] == 0) begin
            for (i = 22; i >= 0; i = i - 1) begin
                if (frac_mul_trunc[i] == 1) begin
                    shift_count = 22 - i + 2;
                    norm_count = i - 22;
                    i = -1; //used to break for loop
                end
            end
            frac_mul_trunc = frac_mul_trunc << shift_count;
        end
        else if (frac_mul_trunc[24] == 0 && frac_mul_trunc[23] == 1) begin
            norm_count = 0;
            frac_mul_trunc = frac_mul_trunc << 1;
        end
        else begin
            norm_count = 1;
        end

        res_exp = res_exp + norm_count;
        res_exp = res_exp + 127;
        if (res_exp > 255 || res_exp < 0)
            $display("Exception");
        else begin
            result[30:23] = res_exp;
            result[31] = a[23] ^ b[23];
            result[22:0] = frac_mul_trunc[23:1];
        end
    end
endtask
endmodule
