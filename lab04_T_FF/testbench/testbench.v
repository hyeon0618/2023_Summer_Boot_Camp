`timescale 1ns/1ns
`define T_CLK 10

module testbench ();

reg clk;
reg n_rst;
reg t;
wire q_t_1;

t_ff u_t_ff(
    .clk(clk),
    .n_rst(n_rst),
    .t(t),
    .q_t_1(q_t_1)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    t = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) t = 1'b1;
    #(`T_CLK) t = 1'b0;
    #(`T_CLK) t = 1'b1;
    #(`T_CLK) t = 1'b1;
    #(`T_CLK) t = 1'b0;
    #(`T_CLK) t = 1'b1;

    #(`T_CLK * 5) $stop;
end


    
endmodule