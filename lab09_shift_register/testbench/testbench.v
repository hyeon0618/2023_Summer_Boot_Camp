`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
reg clk;
reg n_rst;
reg data;
wire [3:0] dout;

shift_register u_shift_register(
    .clk(clk),
    .n_rst(n_rst),
    .data(data),
    .dout(dout)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~ n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    data = 1'b0;

    wait(n_rst == 1'b1);

    #(`T_CLK) data = 1'b1;
    #(`T_CLK) data = 1'b0;
    #(`T_CLK) data = 1'b0;
    #(`T_CLK) data = 1'b1;

    #(`T_CLK * 10) $stop;
end

endmodule