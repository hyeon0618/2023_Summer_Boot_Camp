`timescale 1ns/1ns
`define T_CLK 10

module testbench ();
    
reg [3:0] din;
wire dout;

parity_check u_parity_check(
    .din(din),
    .dout(dout)
);

initial begin
    din = 4'b0000;
    #10 din = 4'b1000;
    #10 din = 4'b1010;

    #10 $stop;
end

endmodule