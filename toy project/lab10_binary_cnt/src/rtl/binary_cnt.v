module binary_cnt (
    input clk,
    input n_rst,
    input start,
    output reg [3:0]cnt
);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 4'b0;
    else begin
        if(start == 1'b1) begin
            if(cnt < 4'hf)
                cnt <= cnt + 4'b1;
            else if(cnt == 4'hf)
                cnt <= 4'h0;
        else
            cnt <= cnt;
        end
    end
endmodule