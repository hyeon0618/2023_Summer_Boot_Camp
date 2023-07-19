module sr_ff (
    input clk,
    input n_rst,
    input s,
    input r,
    output reg q_t
);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q_t <= 1'b0;
    else if(s==1'b0) begin
        q_t <= (r==1'b0)?q_t:1'b0;
        end
    else begin
        q_t = (r==1'b0)?1'b1:1'bz;
    end
        
endmodule