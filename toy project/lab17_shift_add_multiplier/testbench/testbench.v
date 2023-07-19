`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
reg clk;
reg n_rst;
reg start;
reg [3:0] multiplicand;
reg [3:0] multiplier;
wire [7:0] product;

shift_add_multi u_shift_add_multi(
    .clk(clk),
    .n_rst(n_rst),
    .start(start),
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .product(product)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    multiplicand = 4'b0010;
    multiplier = 4'b0011;
    start = 1'b0;

    wait(n_rst == 1'b1);
    start = 1'b1;
    #(`T_CLK * 5)
    start = 1'b0;   
    multiplicand = 4'b1001;
    multiplier = 4'b1001;
    #(`T_CLK) start = 1'b1;
    #(`T_CLK * 5) start = 1'b0;

    #(`T_CLK * 5) $stop;
end

endmodule