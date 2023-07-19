module shift_register (
    input clk,
    input n_rst,
    input data,
    output reg [3:0] dout
);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        dout <= 4'b0;
    else begin
            dout <= {data, dout[3:1]};
    end
endmodule