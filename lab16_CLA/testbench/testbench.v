`timescale 1ns/1ns

module testbench ();
    
reg [3:0] A, B;
reg c_in;
wire [3:0] sum;
wire c_out;

cla_4bit u_cla(
    .A(A),
    .B(B),
    .c_in(c_in),
    .sum(sum),
    .c_out(c_out)
);

initial begin
    A = 4'b0000;
    B = 4'b0000;
    c_in = 1'b0;

    #10 A = 4'b1010;
        B = 4'b1100;
        c_in = 1'b1;

    #10 A = 4'b1001;
        B = 4'b1010;
        c_in = 1'b1;
    
    #10 $stop;
end
endmodule