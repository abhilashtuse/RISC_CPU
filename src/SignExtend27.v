module SignExtend27(sOut27, sIn5, reset);
    output [31:0] sOut27;
    input [4:0] sIn5;
    input reset;
    reg [31:0] sOut27;
    always @*
        begin
            if(reset == 1)
                sOut27 = 0;
            else
                 sOut27 = {{27{1'b0}},sIn5};
        end
endmodule
