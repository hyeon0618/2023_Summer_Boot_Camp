module half_adder (
    input a,
    input b,
    output sum,
    output c_out
);

assign sum = a ^ b;
assign c_out = a & b;
    
endmodule