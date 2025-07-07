module fsm (
    input clk,
    input reset,
    input start,
    input [15:0] mac_out_in_fsm,
    input [127:0] A_in_flat,
    input [127:0] B_in_flat,

    output reg [7:0] a_out ,
    output reg [7:0] b_out ,
    output enable_from_fsm,
    output reg [256:0] C_out,
    output reg done
    );

    reg [7:0] A [15:0] ;
    reg [7:0] B [15:0] ;
    reg [15:0] C [15:0] ;

    reg [2:0] state, next_state ;
    reg [2:0] row, col, k;


    reg enable_mac; 
    reg next_flag;
    reg k_flag;
    reg save_flag;
    assign enable_from_fsm = enable_mac; 

integer i;
always @(*) begin
            for (i = 0; i < 16; i = i + 1) begin
            A[i] <= A_in_flat[i*8 +: 8];
            B[i] <= B_in_flat[i*8 +: 8];
        end
    
end

/*
always@(*) begin
    A[0]  = A_in_flat[7:0];
    A[1]  = A_in_flat[15:8];
    A[2]  = A_in_flat[23:16];
    A[3]  = A_in_flat[31:24];
    A[4]  = A_in_flat[39:32];
    A[5]  = A_in_flat[47:40];
    A[6]  = A_in_flat[55:48];
    A[7]  = A_in_flat[63:56];
    A[8]  = A_in_flat[71:64];
    A[9]  = A_in_flat[79:72];
    A[10] = A_in_flat[87:80];
    A[11] = A_in_flat[95:88];
    A[12] = A_in_flat[103:96];
    A[13] = A_in_flat[111:104];
    A[14] = A_in_flat[119:112];
    A[15] = A_in_flat[127:120];

    B[0]  = B_in_flat[7:0];
    B[1]  = B_in_flat[15:8];
    B[2]  = B_in_flat[23:16];
    B[3]  = B_in_flat[31:24];
    B[4]  = B_in_flat[39:32];
    B[5]  = B_in_flat[47:40];
    B[6]  = B_in_flat[55:48];
    B[7]  = B_in_flat[63:56];
    B[8]  = B_in_flat[71:64];
    B[9]  = B_in_flat[79:72];
    B[10] = B_in_flat[87:80];
    B[11] = B_in_flat[95:88];
    B[12] = B_in_flat[103:96];
    B[13] = B_in_flat[111:104];
    B[14] = B_in_flat[119:112];
    B[15] = B_in_flat[127:120];
end
*/
 
    /*initial begin
        A[0] = 1; A[1] = 2; A[2] = 3; A[3] = 4;
        A[4] = 5; A[5] = 6; A[6] = 7; A[7] = 8;
        A[8] = 1; A[9] = 0; A[10] = 2; A[11] = 3;
        A[12] = 4; A[13] = 1; A[14] = 0; A[15] = 2;

        B[0] = 1; B[1] = 0; B[2] = 2; B[3] = 3;
        B[4] = 4; B[5] = 1; B[6] = 0; B[7] = 2;
        B[8] = 1; B[9] = 2; B[10] = 1; B[11] = 0;
        B[12] = 3; B[13] = 0; B[14] = 4; B[15] = 1;
    end */

    localparam [3:0] IDLE = 3'd0,
               LOAD = 3'd1,
               MAC_LOOP = 3'd2, 
               SAVE = 3'd3,
               NEXT = 3'd4,
               DONE = 3'd5;


    always @(posedge clk) begin

        a_out <= 0;
        b_out <= 0;
        done <= 0;
        k_flag <= 0;
        save_flag <= 0;
        enable_mac <= 0;
        next_flag <= 0;

        if (reset) begin
            state <= IDLE;

        end
        else 
            state <= next_state;

        case (state)

            IDLE: next_state <= (start) ? LOAD : IDLE;

            LOAD: begin 
                     next_state <= MAC_LOOP;
                     row <=0;
                     col <=0;
                     k <= 0;
            end

            MAC_LOOP: begin 
            if (k_flag ==0) begin
                enable_mac <= 1;
                a_out <= A[row*4 +k];
                b_out <= B[col + k*4];
                if (k<3) k <= k+1 ;
                next_state <= (k==3) ? SAVE : MAC_LOOP;
                if (k==3) begin 
                    k <=0;
                    k_flag <= 1;
                end
            end
            end

            SAVE: begin
                if (save_flag ==0) begin
                C[row*4 + col] <= mac_out_in_fsm;
                next_state <= NEXT;
                //state <= NEXT;
                save_flag <= 1;
                end
                
                //k <= 0;

            end

            NEXT: begin
            next_flag <= 1;
            
            if (next_flag ==0) begin
                if (col<3) begin
                    col <= col +1;    
                    next_state <= MAC_LOOP;                
                end
                else if(col ==3 && row <3) begin
                    row <= row +1;
                    col <= 0;
                    next_state <= MAC_LOOP;
                end
                if (row==3 && col==3) begin
                    next_state <= DONE;
                    row <= 0;
                    col <= 0;
                
                end   
            end             
            end

            DONE: begin
                done <= 1;

                C_out <= {C[15], C[14], C[13], C[12], C[11], C[10], C[9], C[8],
                            C[7], C[6], C[5], C[4], C[3], C[2], C[1], C[0]};
            end
                        
        endcase
    end
    
    

endmodule