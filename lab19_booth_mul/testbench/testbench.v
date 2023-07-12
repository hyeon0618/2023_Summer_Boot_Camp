`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
reg clk;
reg n_rst;
reg [3:0] multiplicant;
reg [3:0] multiplier;
wire [7:0] product;

booth_mul u_booth_mul(
    .clk(clk),
    .n_rst(n_rst),
    .multiplicant(multiplicant),
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
    multiplicant = 4'b0011;
    multiplier = 4'b1100;

    wait(n_rst == 1'b1);

    #(`T_CLK * 10) $stop;
end

endmodule