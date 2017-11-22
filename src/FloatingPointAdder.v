module FloatingPointAdder(result, a, b, clk);
    input clk;
    input[31:0] a, b;
    output [31:0] result;

    integer i, normalize_shift_count;
    reg select;
    reg[31:0] result;
    reg[7:0] delta_exp, exp1, exp2;
    reg[8:0] res_exp;
    reg[23:0] frac1, frac2;
    reg[24:0] frac_sum;


    always @(posedge clk)
    begin
        frac1[23] = 1;
        frac2[23] = 1;
        frac1[22:0] = a[22:0];
        frac2[22:0] = b[22:0];
        exp1 = a[30:23];
        exp2 = b[30:23];
        $display("\ndelta[7]:", delta_exp[7]);
        if (exp1 >= exp2) begin
            delta_exp = exp1 - exp2;
            select = 0;
        end
        else begin
            delta_exp = exp2 - exp1;
            select = 1;
        end

        if (select) begin
            frac1 = frac1 >> delta_exp;
        end
        else begin
            $display("\nbefore:");
            for (i = 22; i >= 0; i=i-1)
                $write(frac2[i]);
            frac2 = frac2 >> delta_exp;
            $display("\nafter:");
            for (i = 22; i >= 0; i=i-1)
                $write(frac2[i]);
        end
        if (a[31] && b[31] == 0)
            frac_sum = frac2 - frac1;
        else if (b[31] && a[31] == 0)
            frac_sum = frac1 - frac2;
        else
            frac_sum = frac1 + frac2;

        $display("\nfsum:");
        for (i = 24; i >= 0; i=i-1)
            $write(frac_sum[i]);

        normalize_shift_count = 0;
        if (frac_sum[24] == 0 && frac_sum[23])
            normalize_shift_count = 0;
        else if (frac_sum[24]) begin
            normalize_shift_count = 1;
            frac_sum = frac_sum >> normalize_shift_count;
        end
        else begin
            for (i = 22; i >= 0; i = i - 1) begin
                if (frac_sum[i] == 1) begin
                    normalize_shift_count = 22 - i + 1;
                    i = -1; //used to break for loop
                end
            end
            frac_sum = frac_sum << normalize_shift_count;
            normalize_shift_count = normalize_shift_count * -1;
        end
        $display("\nNorm_count:", normalize_shift_count);
        res_exp = (normalize_shift_count) + (select ? exp2 : exp1);
        if (res_exp > 255 || res_exp < 0)
            $display("Exception");
        else begin
            result[31] = frac_sum[22];
            result[30:23] = res_exp[7:0];
            result[22:0] = frac_sum;
        end
    end
endmodule
