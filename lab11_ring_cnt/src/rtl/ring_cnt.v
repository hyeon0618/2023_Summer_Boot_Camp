module ring_cnt (
    input clk,
    input n_rst,
    output reg [3:0] d_out // data out
);

reg [1:0] cnt;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 2'b0;
    else
        cnt <= (cnt < 2'h3)? cnt + 2'b1 : 2'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        d_out <= 4'b1000;
    else begin
        if(cnt <= 2'h3)
            d_out <= {d_out[2:0], d_out[3]};
    end


endmodule