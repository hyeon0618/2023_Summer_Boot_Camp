module full_adder (
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
);

assign sum = a ^ b ^ c_in;
assign c_out = (a ^ b) & b | (a & b);

    
endmodule