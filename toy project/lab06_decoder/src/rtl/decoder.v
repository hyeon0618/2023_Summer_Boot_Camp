module decoder (
    input [1:0] din,
    output reg [3:0] dout
);

always @(din)
dout = (din == 2'b00)? 4'b0001 :
       (din == 2'b01)? 4'b0010 :
       (din == 2'b10)? 4'b0100 : 4'b1000;

endmodule