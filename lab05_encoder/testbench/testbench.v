`timescale 1ns/1ns

module testbench ();

reg [3:0] din;
wire [1:0] dout;

decoder u_decoder(
    .din(din),
    .dout(dout)
);

initial begin
    din = 4'b0000;

    #10 din = 4'b0001;
    #10 din = 4'b0010;
    #10 din = 4'b0100;
    #10 din = 4'b1000;

    #10 $stop;
end

endmodule