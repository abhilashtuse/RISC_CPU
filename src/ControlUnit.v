module ControlUnit(RF_WE, DM_WE, OPC, reset, clk);
input[5:0] OPC;
input reset, clk;
output RF_WE, DM_WE;

wire[5:0] D6, D10;
reg[5:0] Q6, Q10;
reg RF_WE, DM_WE;

always @(posedge clk or reset)
begin
    if(reset == 1) begin
        RF_WE <= 0;
        DM_WE <= 0;
    end
    else begin
        Q6 <= OPC;
        case(Q6)
            1: begin
                    Q10 <= Q6;
                    case (Q10)
                        1 : RF_WE <= 1; //ADD
                        2 : RF_WE <= 1; //SUB
                    endcase
                end
            3: begin
                    DM_WE <= 1; //Store
                end
        endcase
    end
end

endmodule
