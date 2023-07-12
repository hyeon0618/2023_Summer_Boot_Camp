`timescale 1ns/1ns

module testbench ();
    
reg [3:0] a, b;
reg c_in;
wire c_out;
wire [3:0] sum;

rca_4bit u_rca_4bit1(
    .a(a),
    .b(b),
    .c_in(c_in),
    .c_out(c_out),
    .sum(sum)
);

initial begin
    a = 4'b0000;
    b = 4'b0000;
    c_in = 1'b0;

    #10 a = 4'b0111;
        b = 4'b0100;
        c_in = 1'b1;

    #10 a = 4'b0101;
        b = 4'b0010;
        c_in = 1'b0;
    
    #10 $stop;
end

endmodule