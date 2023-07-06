`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
reg clk;
reg n_rst;
reg start;
wire [3:0] cnt;

binary_cnt u_binary_cnt(
    .clk(clk),
    .n_rst(n_rst),
    .start(start),
    .cnt(cnt)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    start = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b1;
    //#(`T_CLK) start = 1'b0;

    #(`T_CLK * 17) $stop;
end
endmodule