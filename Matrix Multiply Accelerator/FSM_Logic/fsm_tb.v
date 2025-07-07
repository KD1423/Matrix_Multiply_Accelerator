module fsm_tb;

reg clk;
reg reset;
reg start;
reg [15:0] mac_out_in_fsm;
wire [7:0] a_out;
wire [7:0] b_out;
wire [225:0] C ; 
wire done;

fsm dut (clk, reset, start, mac_out_in_fsm, a_out, b_out, enable_from_fsm, C, done);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        start = 1;
        #6;
        reset = 0;
    end

    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars(0, fsm_tb);

        #3;
        $monitor("%d \t%d", a_out, b_out, mac_out_in_fsm);


        #2000;
        $display("C: %b", C);

        $finish;
    end

endmodule