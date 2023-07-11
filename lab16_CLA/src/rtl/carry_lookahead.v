module carry_lookahead (
    input [3:0] A, B,
    input c_in,
    output [3:0] P, G,
    output [3:0] c_out
);

assign P = A ^ B;
assign G = A & B;

assign c_out[0] = G[0] | (P[0] & c_in);
assign c_out[1] = G[1] | (P[1] & c_out[0]);
assign c_out[2] = G[2] | (P[2] & c_out[1]);
assign c_out[3] = G[3] | (P[3] & c_out[2]);

endmodule