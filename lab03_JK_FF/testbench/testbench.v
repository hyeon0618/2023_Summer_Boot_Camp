`timescale 1ns/1ns
`define T_CLK 10

module testbench ();

reg clk;
reg n_rst;
reg j;
reg k;
wire q_t;

jk_ff u_jk_ff(
    .clk(clk),
    .n_rst(n_rst),
    .j(j),
    .k(k),
    .q_t(q_t)
);

always #(`T_CLK / 2) clk = ~clk;

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

initial begin
    j = 1'b0;
    k = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) j = 0;
              k = 0;
    #(`T_CLK) j = 0;
              k = 1;
    #(`T_CLK) j = 1;
              k = 0;
    #(`T_CLK) j = 1;
              k = 1;
    
    #(`T_CLK * 10) $stop;
end

endmodule