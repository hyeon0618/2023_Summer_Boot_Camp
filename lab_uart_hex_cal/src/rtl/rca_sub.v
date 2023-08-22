module rca_sub (
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum,
    output c_out
);
    
wire c1, c2, c3;
wire [3:0] s_b;

sub u_sub(
    .b(b),
    .s_b(s_b)
);

full_adder u_full_adder1(
    .a(a[0]),
    .b(s_b[0]),
    .c_in(c_in),
    .sum(sum[0]),
    .c_out(c1)
);

full_adder u_full_adder2(
    .a(a[1]),
    .b(s_b[1]),
    .c_in(c1),
    .sum(sum[1]),
    .c_out(c2)
);

full_adder u_full_adder3(
    .a(a[2]),
    .b(s_b[2]),
    .c_in(c2),
    .sum(sum[2]),
    .c_out(c3)
);

full_adder u_full_adder4(
    .a(a[3]),
    .b(s_b[3]),
    .c_in(c3),
    .sum(sum[3]),
    .c_out(c_out)
);


endmodule