`timescale 1ns/100ps
`define T_CLK 10

module testbench ();

reg clk;
reg n_rst;
reg [15:0] M;
reg [15:0] Q;
reg parser_done;
wire [31:0] result;
wire alu_done;

unsigned_mul u_um(
    .clk(clk),
    .n_rst(n_rst),
    .M(M),
    .Q(Q),
    .parser_done(parser_done),
    .result(result),
    .alu_done(alu_done)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    M = 16'h3;
    Q = 16'h4;
    parser_done = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK)parser_done = 1'b1;
    #(`T_CLK) parser_done = 1'b0;
    #(`T_CLK * 20) 
    M = 16'd13;
    Q = 16'd13;
    #(`T_CLK) parser_done = 1'b1;
    #(`T_CLK) parser_done = 1'b0;
    #(`T_CLK * 20) $stop;
end

endmodule