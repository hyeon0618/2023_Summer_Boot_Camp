module mux (
    input [3:0] din,
    input [1:0] sel,
    output dout
);

assign dout = (sel == 2'b00)? din[0] :
              (sel == 2'b01)? din[1] :
              (sel == 2'b10)? din[2] : din[3];


endmodule