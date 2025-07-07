module mac_tb;

reg clk;
reg reset;
reg enable;
reg [7:0] a;
reg [7:0] b;
wire [15:0] acc_out;

mac uut (.clk(clk), .reset(reset), .enable(enable), .a(a), .b(b), .acc_out(acc_out));

always #5 clk = ~clk;

initial begin

    $dumpfile("mac_unit.vcd");
    $dumpvars(0,mac_tb);

    clk = 0;
    reset = 1;
    enable = 0;
    #6
    enable = 1;
    reset = 0;

    #1
    a = 8'd2;
    b = 8'd3;

    $monitor("%d", acc_out);

    #100
    $finish;
    
end
endmodule