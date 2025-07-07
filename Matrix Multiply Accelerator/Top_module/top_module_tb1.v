module top_tb1;

reg clk;
reg reset;
reg enable;
wire [15:0] mac_output;

top1 uut (.clk(clk), .reset(reset), .enable(enable), .mac_output(mac_output));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    reset = 1;
    #6;
    reset = 0;
end

initial begin
    enable = 0;
    #17;
    enable = 1;
end

initial begin
    $dumpfile("topwave1.vcd");
    $dumpvars(0, top_tb1);

    /*uut.fsm_inst.a0 = 8'd1;
    uut.fsm_inst.a1 = 8'd2;
    uut.fsm_inst.a2 = 8'd3;
    uut.fsm_inst.a3 = 8'd4;

    uut.fsm_inst.b0 = 8'd3;
    uut.fsm_inst.b1 = 8'd4;
    uut.fsm_inst.b2 = 8'd5;
    uut.fsm_inst.b3 = 8'd6;*/

    #100;
    $finish;
end

endmodule