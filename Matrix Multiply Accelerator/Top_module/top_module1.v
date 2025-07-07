module top1 (
    input clk,
    input reset,
    input enable,
    output [15:0] mac_output
    );

    wire [7:0] wire_a ;
    wire [7:0] wire_b ;

    reg [7:0] a0_reg = 8'd1;
    reg [7:0] a1_reg = 8'd2;
    reg [7:0] a2_reg = 8'd3;
    reg [7:0] a3_reg = 8'd4;

    reg [7:0] b0_reg = 8'd4;
    reg [7:0] b1_reg = 8'd5;
    reg [7:0] b2_reg = 8'd6;
    reg [7:0] b3_reg = 8'd7;


    mac mac_inst (.clk(clk), .reset(reset), .enable(enable), .a(wire_a), .b(wire_b),
                  .mac_out(mac_output) );

    fsm1 fsm1_inst (.clk(clk), .reset(reset), .a0(a0_reg), .a1(a1_reg), 
                  .a2(a2_reg), .a3(a3_reg), .b0(b0_reg), .b1(b1_reg), .b2(b2_reg), .b3(b3_reg),
                  .a_out(wire_a), .b_out(wire_b));

endmodule