module rca_32bit(
    input [31:0] a,
    input [31:0] b,
    input c_in,
    output [31:0] sum,
    output c_out
);

wire c1, c2, c3, c4, c5, c6 ,c7;

rca_sub u_rca_sub1(
    .a(a[3:0]),
    .b(b[0]),
    .c_in(c_in),
    .sum(sum[3:0]),
    .c_out(c1)
);

rca_sub u_rca_sub2(
    .a(a[7:4]),
    .b(b[1]),
    .c_in(c1),
    .sum(sum[7:4]),
    .c_out(c2)
);

rca_sub u_rca_sub3(
    .a(a[11:8]),
    .b(b[2]),
    .c_in(c2),
    .sum(sum[11:8]),
    .c_out(c3)
);

rca_sub u_rca_sub4(
    .a(a[15:12]),
    .b(b[3]),
    .c_in(c3),
    .sum(sum[15:12]),
    .c_out(c4)
);

rca_sub u_rca_sub5(
    .a(a[19:16]),
    .b(b[4]),
    .c_in(c4),
    .sum(sum[19:16]),
    .c_out(c5)
);

rca_sub u_rca_sub6(
    .a(a[23:20]),
    .b(b[5]),
    .c_in(c5),
    .sum(sum[23:20]),
    .c_out(c6)
);

rca_sub u_rca_sub7(
    .a(a[27:24]),
    .b(b[6]),
    .c_in(c6),
    .sum(sum[27:24]),
    .c_out(c7)
);

rca_sub u_rca_sub8(
    .a(a[31:28]),
    .b(b[7]),
    .c_in(c7),
    .sum(sum[31:28]),
    .c_out(c_out)
);

endmodule