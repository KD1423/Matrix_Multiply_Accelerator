module mac (
    input clk,
    input reset,
    input enable,
    input [7:0] a, 
    input [7:0] b,
    output  [15:0] mac_out
    );

    reg [15:0] acc_reg;
    reg [2:0] count;


    always @(posedge clk) begin

        if (reset) begin
            acc_reg <= 0;
            count <= 0;
        end

        else if (enable) begin

            acc_reg <= acc_reg + (a*b);
            count <= count + 1;

        end
        else begin
            acc_reg <= 0;
            count <= 0;

        end

            
    end

    assign mac_out = (count == 4) ? acc_reg : 0;
    /*always@(posedge clk) begin
    if (count == 4) begin
    mac_out = acc_reg;
    end
    end */



endmodule