`timescale 1ns/1ns

module testbench ();

reg [1:0] din;
wire [3:0] dout;

decoder u_decoder(
    .din(din),
    .dout(dout)
);

initial begin
    din = 2'b00;

    #10 din = 2'b00;
    #10 din = 2'b01;
    #10 din = 2'b10;
    #10 din = 2'b11;

    #10 $stop;
end

endmodule