module fsm1_tb;

    reg clk;
    reg reset;
    reg [7:0] a0;
    reg [7:0] a1;
    reg [7:0] a2;
    reg [7:0] a3;

    reg [7:0] b0;
    reg [7:0] b1;
    reg [7:0] b2;
    reg [7:0] b3;

    output wire [7:0] a_out;
    output wire [7:0] b_out;

    fsm1 dut (clk, reset, a0, a1, a2, a3, b0, b1, b2, b3, a_out, b_out);

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
        $dumpfile("fsm1.vcd");
        $dumpvars(0, fsm1_tb);
        a0 = 8'd1;
        a1 = 8'd2;
        a2 = 8'd3;
        a3 = 8'd4;

        b0 = 8'd3;
        b1 = 8'd4;
        b2 = 8'd5;
        b3 = 8'd6;
        #3;

        $monitor("%d \t%d", a_out, b_out);
        #90;

        $finish;
    end

    endmodule
        
