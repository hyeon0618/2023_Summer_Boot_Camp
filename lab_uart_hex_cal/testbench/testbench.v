`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
reg clk;
reg n_rst;
reg [15:0] M;
reg [15:0] Q;
reg start;
wire [31:0] result;

booth_mul u_booth_mul(
    .clk(clk),
    .n_rst(n_rst),
    .M(M),
    .Q(Q),
    .start(start),
    .result(result)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    M = 16'h8011;
    Q = 16'b0000_0000_0000_0010;
    start = 1'b0;
    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b1;
    #(`T_CLK) start = 1'b0;

    


    #(`T_CLK * 18) $stop;
end

endmodule