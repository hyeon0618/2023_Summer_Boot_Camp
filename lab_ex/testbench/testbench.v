`timescale 1ps/1ps

module testbench;

reg a;
wire out;

test u_test(
    .a(a),
    .out(out)
);
initial begin
    a= 1'b0;
#10 a = 1'b1;
#10 a = 1'b0;
#10 a = 1'b1; 

#10 $stop;
end
endmodule
