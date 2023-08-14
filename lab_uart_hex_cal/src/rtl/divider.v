module divider (
    input clk,
    input n_rst,
    input [15:0] M, // Divisor
    input [15:0] D_end, // Dividend
    input parser_done,
    output reg [15:0] Q, // Quotient
    output [15:0] R // Remainder
);

reg [3:0] cnt;
reg [15:0] A; // accumulator

wire [15:0] S_A; // shift A
assign S_A = {A[15:1], 1'b0};

wire [15:0] S_Q; // shift Q
assign S_Q = {Q[15:1], 1'b0};

wire [15:0] MINUS_M; // -M
assign MINUS_M =(~M) + 1'b1;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 4'b0;
    else begin
        if(parser_done == 1'b1)
            cnt <= 4'hf;
        else
            cnt <= (cnt == 4'h0)? 4'b0 : cnt - 4'h1;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        A <= 16'b0;
    else begin
        if(cnt != 4'h0) begin
            if(A[15] == 1'b0)
                A <= S_A + MINUS_M;
            else
                A <= S_A + M;
        end
        else begin
            if(A[15] == 1'b0)
                A <= A;
            else
                A <= A + M;
        end
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        Q <= D_end;
    else begin
        if(cnt != 4'h0)
            Q <= (A[15] == 1'b0)? {S_Q[15:1], 1'b1} : {S_Q[15:1], 1'b0}; 
        else
            Q <= Q;
    end

assign R = A;

endmodule