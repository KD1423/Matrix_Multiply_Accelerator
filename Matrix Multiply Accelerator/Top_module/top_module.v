module top (
    input clk,
    input reset,
    input start,
    output [15:0] mac_output,
    output [255:0] C_out_top,
    output done
    );

    wire [7:0] wire_a ;
    wire [7:0] wire_b ;
    wire enable_wire; 
    wire [15:0] mac_out_wire;
    wire [256:0] C_out_wire;
    //wire done_wire;

    assign mac_output = mac_out_wire;
    assign C_out_top = C_out_wire;
    reg [127:0] A_in_flat_value = 128'h02000104_02000301_08070605_04030201;
    reg [127:0] B_in_flat_value = 128'h01040000_01010202_02000104_03020001;

    mac mac_inst (.clk(clk), .reset(reset), .enable(enable_wire), .a(wire_a), .b(wire_b),
                  .mac_out(mac_out_wire) );

    fsm fsm_inst (.clk(clk), .reset(reset), .start(start), .mac_out_in_fsm(mac_out_wire),
                    .A_in_flat(A_in_flat_value), .B_in_flat(B_in_flat_value), .a_out(wire_a),
                    .b_out(wire_b), .enable_from_fsm(enable_wire), .C_out(C_out_wire), .done(done));

    

endmodule