module shift_add_multi (
    input clk,
    input n_rst,
    input start,
    input [3:0] multiplicand,
    input [3:0] multiplier,
    output reg [7:0] product
);

reg [7:0] s_multiplicand;
reg [3:0] s_multiplier;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        product <= 8'h0;
    else begin
        if(start == 1'b1 )
            product <= (s_multiplier[0] == 1'b1)? product + s_multiplicand : product;
        else begin
            product <= 8'h0;
        end
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        s_multiplicand <= multiplicand;
    else begin
        if(start == 1'b1)
            s_multiplicand <= s_multiplicand << 1;
        else
            s_multiplicand <= multiplicand;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        s_multiplier <= multiplier;
    else begin
        if(start == 1'b1)
            s_multiplier <= s_multiplier >> 1;
        else
            s_multiplier <= multiplier;
    end


endmodule