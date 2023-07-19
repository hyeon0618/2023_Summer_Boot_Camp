module full_adder (
    input a,
    input b,
    input c_in,
    output [1:0] sum,
    output c_out
);

wire c1;
wire c2;

assign c_out = c1 | c2;

half_adder u_half_adder1(
    .a(a),
    .b(b),
    .sum(sum[0]),
    .c_out(c1)
);

half_adder u_half_adder2(
    .a(c_in),
    .b(sum[0]),
    .sum(sum[1]),
    .c_out(c2)
);
    
endmodule