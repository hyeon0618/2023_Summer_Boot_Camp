`timescale 1ns/100ps
`define T_CLK 10

module testbench ();

reg clk;
reg n_rst;
reg [3:0] M;
reg [3:0] Q;
reg parser_done;
wire [7:0] result;
wire alu_done;

divider_un u_divider_un(
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
    M = 4'd2;
    Q = 4'd7;
    parser_done = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK)parser_done = 1'b1;
    #(`T_CLK) parser_done = 1'b0;
    #(`T_CLK * 20) 
    M = 4'd5;
    Q = 4'd5;
    #(`T_CLK) parser_done = 1'b1;
    #(`T_CLK) parser_done = 1'b0;
    #(`T_CLK * 20) $stop;
end

endmodule