`timescale 1ns/1ns

module testbench ();

reg [3:0] din;
reg [1:0] sel;
wire dout;

mux u_mux(
    .din(din),
    .sel(sel),
    .dout(dout)
);

initial begin
    din = 4'b0000;
    sel = 2'b00;

    #10 din = 4'b1010;
    #10 sel = 2'b00;
    #10 sel = 2'b01;
    #10 sel = 2'b10;
    #10 sel = 2'b11;

    #10 $stop;
end

endmodule