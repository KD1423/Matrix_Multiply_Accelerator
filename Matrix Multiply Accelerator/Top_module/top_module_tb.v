module top_tb;

reg clk;
reg reset;
reg start;
wire [15:0] mac_output;
wire done;
wire [255:0] C_out_top_tb;
    integer i;


top uut (.clk(clk), .reset(reset), .start(start), .mac_output(mac_output),
         .C_out_top(C_out_top_tb), .done(done));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    start = 1;
    reset = 1;
    #6;
    reset = 0;
end



initial begin
    $dumpfile("topwave.vcd");
    $dumpvars(0, top_tb);

    //$monitor("%d \t%d \t%d", mac_output, uut.fsm_inst.mac_out_in_fsm, uut.fsm_inst.C_out);

    //$monitor("C = %b", uut.fsm_inst.C[uut.fsm_inst.row*4 + uut.fsm_inst.col]);
    #5;
    //$monitor("C0_out = %d, MAC_in = %b, \tTime = %t", uut.fsm_inst.C[0], uut.fsm_inst.mac_out_in_fsm, $time);
    #2500;
    $display("C_out is = %b \n", C_out_top_tb);

    $display("Matrix A is : ");
    for (i = 0; i<16; i = i+1) begin
        $write("%2d \t",uut.fsm_inst.A[i]);
        if (((i%4) ==3) & i>0 ) $write("\n");
    end

    $display("Matrix B is : ");
    for (i = 0; i<16; i = i+1) begin
        $write("%2d \t",uut.fsm_inst.B[i]);
        if (((i%4) ==3) & i>0 ) $write("\n");
    end

    $display("Matrix C is : ");
    for (i = 0; i<16; i = i+1) begin
        $write("%2d \t",uut.fsm_inst.C[i]);
        if (((i%4) ==3) & i>0 ) $write("\n");
    end
    

    #30;
    $finish;


end

endmodule