module sub (
    input [3:0] b,
    output [3:0] s_b
);

assign s_b = ~b + 1'b1;
    
endmodule