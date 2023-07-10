module parity_check (
    input [3:0] din,
    output dout
);

assign dout = (din[0] ^ din[1] ^ din[2] ^ din[3] == 1'b0)? 1'b0 : 1'b1;
    
endmodule