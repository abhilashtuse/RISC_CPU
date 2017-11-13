module sign_extend(sOut32, sIn16, reset);
    output [31:0] sOut32;
    input [15:0] sIn16;
    input reset;
    reg [31:0] sOut32;
    always @*
        begin
            if(reset == 1)
                sOut32 = 0;
            else
                 sOut32 = {{16{1'b0}},sIn16};
        end
endmodule
