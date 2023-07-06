`timescale 1ns/1ns
`define T_CLK 10

module testbench ();

reg clk;
reg n_rst;
reg d;
wire q;

d_ff u_d_ff(
    .clk(clk),
    .n_rst(n_rst),
    .d(d),
    .q(q)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    d = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) d = 1'b1;
    #(`T_CLK) d = 1'b1;
    #(`T_CLK) d = 1'b0;
    #(`T_CLK) d = 1'b1;

    #(`T_CLK * 5) $stop; 
end

endmodule