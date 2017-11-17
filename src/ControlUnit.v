module ControlUnit(RF_WE, DM_WE, Q6,Q10,reset, clk);
    input[5:0] Q6, Q10;
//    input[31:0] ;
    input reset, clk;
    output RF_WE, DM_WE;
    //output [31:0] Q13;

    wire[5:0] D10;
    //reg[5:0] Q10;
    reg[31:0] Q13;
    reg RF_WE, DM_WE;

    always @*
    begin
        if(reset == 1) begin
            RF_WE <= 0;
            DM_WE <= 0;
        end
        else begin
            if(reset == 0) begin
                case(Q6)
                    1,2: begin
                            //$display(Q10);
                            case (Q10)
                                1 : RF_WE <= 1; //ADD
                                2 : RF_WE <= 1; //SUB
                                3 : DM_WE <= 1; //Store
                            endcase
                        end
                    3: begin
                            DM_WE <= 1; //Store
                        end
                endcase
            end
        end
    end

endmodule
