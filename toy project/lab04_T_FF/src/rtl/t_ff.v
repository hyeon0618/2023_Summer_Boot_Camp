module t_ff (
    input clk,
    input n_rst,
    input t,
    output reg q_t_1 // next state
);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t_1 <= 1'b0;
    else begin
        q_t_1 <= (t == 1'b1)? ~q_t_1 : q_t_1;
    end

endmodule