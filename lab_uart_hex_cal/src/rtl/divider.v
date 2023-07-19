module devider (
    input clk,
    input n_rst,
    input [15:0] D, // Divisor
    input [15:0] D_end, // Dividend
    output [15:0] Q, // Quotient
    output [15:0] R // Remainder
);
    
endmodule