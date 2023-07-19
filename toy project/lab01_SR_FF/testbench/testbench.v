`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
  
reg clk;
reg n_rst;
reg s;
reg r;
wire q_t;

sr_ff u_sr_ff(
    .clk(clk),
    .n_rst(n_rst),
    .s(s),
    .r(r),
    .q_t(q_t)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = !n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    s = 1'b0;
    r = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) s = 1'b0;
              r = 1'b0;
    #(`T_CLK) s = 1'b0;
              r = 1'b1;
    #(`T_CLK) s = 1'b1;
              r = 1'b0;

    #(`T_CLK * 5) $stop; 
end
    
endmodule