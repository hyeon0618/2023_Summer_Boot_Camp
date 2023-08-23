`timescale 1ns/100ps
`define T_CLK 10

module testbench ();

reg clk;
reg n_rst;
reg RXD;
wire TXD;

top u_top(
    .clk(clk),
    .n_rst(n_rst),
    .RXD(RXD),
    .TXD(TXD)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    RXD = 1'b1;

    wait(n_rst == 1'b1);
    #(`T_CLK * 200) RXD = 1'b0;//US
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 5500);
    #(`T_CLK * 200) RXD = 1'b0;//5
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 5500);
    #(`T_CLK * 200) RXD = 1'b0;//6
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 5500);
    #(`T_CLK * 200) RXD = 1'b0;// /
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 5500);
    #(`T_CLK * 200) RXD = 1'b0;//8
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 5500);
    /*#(`T_CLK * 200) RXD = 1'b0;//6
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 5500);*/
     #(`T_CLK * 200) RXD = 1'b0;//=
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b0;
    #(`T_CLK * 434) RXD = 1'b1;
    #(`T_CLK * 10000) $stop;
end

endmodule