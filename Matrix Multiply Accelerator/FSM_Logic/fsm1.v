module fsm1 (
    input clk,
    input reset,
    input [7:0] a0,
    input [7:0] a1,
    input [7:0] a2,
    input [7:0] a3,

    input [7:0] b0,
    input [7:0] b1,
    input [7:0] b2,
    input [7:0] b3,

    output reg [7:0] a_out,
    output reg [7:0] b_out

    );

    reg [2:0] counter;

    always@(posedge clk) begin

        if (reset) begin
            counter <= 0;
            //a_out <= 0;
            //b_out <= 0;
        end

        else if(counter < 4) begin
        counter <= counter + 1;

        case(counter)
        0: begin a_out <= a0;
                 b_out <= b0;
           end

        1: begin a_out <= a1;
                 b_out <= b1;
           end

        2: begin a_out <= a2;
                 b_out <= b2;
           end
        
        3: begin a_out <= a3;
                 b_out <= b3;
           end

        endcase
        end

        else if(counter == 4) begin
        counter <= 0;
        end
    end


endmodule