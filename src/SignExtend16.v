module SignExtend16(sOut16, sIn16, reset);
    output [31:0] sOut16;
    input [15:0] sIn16;
    input reset;
    reg [31:0] sOut16;
    always @*
        begin
            if(reset == 1)
                sOut16 = 0;
            else
                 sOut16 = {{16{1'b0}},sIn16};
        end
endmodule
