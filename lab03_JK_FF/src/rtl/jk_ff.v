module jk_ff (
    input clk,
    input n_rst,
    input j,
    input k,
    output reg q_t
);

reg q_t_1;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t <= 1'b0;
    else
        q_t <= q_t_1;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst)
        q_t_1 <= 1'b0;
    else begin
        if(j == 0) begin
            q_t_1 <= (k == 0)? q_t : 1'b0;
        end
        else begin
            q_t_1 <= (k == 0)? 1'b1 : ~q_t_1;
        end
    end   
end

endmodule