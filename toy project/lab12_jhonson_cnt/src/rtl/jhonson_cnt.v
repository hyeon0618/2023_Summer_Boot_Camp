module jhonson_cnt (
    input clk,
    input n_rst,
    output reg [3:0] q
);

reg [2:0] cnt;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 3'b0;
    else
        cnt <= (cnt < 3'h7)? cnt + 3'b1 : 3'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q <= 4'b0000;
    else begin
        if(cnt <= 3'h7)
            q <= {q[2:0], ~q[3]};
    end
    
endmodule