module full_adder (
    input A,
    input B,
    input c_in,
    output sum,
    output c_out
);

assign sum = A ^ B ^ c_in;
assign c_out = ((A ^ B) & c_in) | (A & B);

endmodule