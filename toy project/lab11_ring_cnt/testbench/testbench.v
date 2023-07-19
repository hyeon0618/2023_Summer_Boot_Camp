`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
    reg clk;
    reg n_rst;
    wire [3:0] d_out;

ring_cnt u_ring_cnt(
    .clk(clk),
    .n_rst(n_rst),
    .d_out(d_out)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    wait(n_rst == 1'b1);
    #(`T_CLK * 10);
    #(`T_CLK * 5) $stop;
end

endmodule