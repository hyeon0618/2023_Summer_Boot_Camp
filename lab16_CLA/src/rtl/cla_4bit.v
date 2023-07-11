module cla_4bit (
    input [3:0] A,
    input [3:0] B,
    input c_in,
    output [3:0] sum,
    output c_out
);

wire [3:0] P, G;
wire [3:0] C;


full_adder u_fa0(
    .A(A[0]),
    .B(B[0]),
    .c_in(c_in),
    .sum(sum[0]),
    .c_out(C[0])
);

full_adder u_fa1(
    .A(A[1]),
    .B(B[1]),
    .c_in(C[0]),
    .sum(sum[1]),
    .c_out(C[1])
);

full_adder u_fa2(
    .A(A[2]),
    .B(B[2]),
    .c_in(C[1]),
    .sum(sum[2]),
    .c_out(C[2])
);

full_adder u_fa3(
    .A(A[3]),
    .B(B[3]),
    .c_in(C[2]),
    .sum(sum[3]),
    .c_out(C[3])
);

carry_lookahead u_carry_lookahead(
    .A(A),
    .B(B),
    .P(P),
    .G(G),
    .c_in(c_in),
    .c_out(c_out)
);

//assign c_out = C[3];
    
endmodule