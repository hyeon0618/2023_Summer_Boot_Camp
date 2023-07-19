module gray_cnt (
    input clk,
    input n_rst,
    output reg [2:0] q
);

reg [2:0] cnt;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 3'h0;
    else
        cnt <= (cnt < 3'h7)? cnt + 3'h1 : 3'h0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q <= 3'b000;
    else begin
        if(cnt <= 3'h7)
            q <= cnt ^ (cnt >> 1);
    end
endmodule