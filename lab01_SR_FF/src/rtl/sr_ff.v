module sr_ff (
    input clk,
    input n_rst,
    input s,
    input r,
    output reg q_t
);

reg q_t_1;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t <= 1'b0;
    else
        q_t <= q_t_1;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t_1 <= 1'b0;
    else begin
        if(s == 1'b0)
            q_t_1 <= (r == 1'b0)? q_t_1 : 1'b0;
        else if ((s == 1'b1) && (r == 1'b0))
            q_t_1 <= 1'b1;
    end
        
endmodule