module t_ff (
    input clk,
    input n_rst,
    input t,
    output reg q_t_1 // next state
);

reg q_t; // present state

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t <= 1'b0;
    else
        q_t <= q_t_1;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t_1 <= 1'b0;
    else begin
        q_t_1 <= (t == q_t)? 1'b0 : 1'b1;
    end

endmodule