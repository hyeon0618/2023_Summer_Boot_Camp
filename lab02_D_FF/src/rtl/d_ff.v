module d_ff (
    input clk,
    input n_rst,
    input d,
    output reg q
);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q <= 1'b0;
    else begin
        q <= d;
    end

endmodule