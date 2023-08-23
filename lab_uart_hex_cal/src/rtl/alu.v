module alu (
    input clk,
    input n_rst,
    input [3:0] dtype,
    input [4:0] operator,
    input parser_done,
    input [15:0] src1, src2,
    input format,
    output alu_done,
    output reg [31:0] calc_res
);
wire [31:0] calc_res3, calc_res4, calc_res5, calc_res6;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        calc_res <= 32'h0;
    else begin
        if(dtype == 4'h1) begin // Signed
            //if(operator == 5'h01)
                //calc_res <= calc_res1;
            //else if(operator == 5'h02)
                //calc_res <= calc_res2;
            if(operator == 5'h03)
                calc_res <= calc_res3;
            else if(operator == 5'h04)
                calc_res <= calc_res5;
        end
        else if(dtype == 4'h2) begin
            //if(operator == 5'h01)
                //calc_res <= calc_res1;
            //else if(operator == 5'h02)
                //calc_res <= calc_res2;
            if(operator == 5'h03)
                calc_res <= calc_res4;
            else if(operator == 5'h04)
                calc_res <= calc_res6;
        end
    end


/*rca_32bit u_rca_32bit(
    .a(src1),
    .b(src2),
    .c_in(),
    .sum(calc_res1),
    .c_out()
);

rca_sub32 u_rca_sub32(
    .a(src1),
    .b(src2),
    .c_in(),
    .sum(calc_res2),
    .c_out()
);*/

booth_mul u_booth_mul(
    .clk(clk),
    .n_rst(n_rst),
    .M(src1),
    .Q(src2),
    .parser_done(parser_done),
    .result(calc_res3),
    .alu_done(alu_done)
);

unsigned_mul u_unsigned_mul(
    .clk(clk),
    .n_rst(n_rst),
    .M(src1),
    .Q(src2),
    .parser_done(parser_done),
    .result(calc_res4),
    .alu_done(alu_done)
);

divider u_divider(
    .clk(clk),
    .n_rst(n_rst),
    .M(src1),
    .Q(src2),
    .parser_done(parser_done),
    .result(calc_res5),
    .alu_done(alu_done)
);

divider_un u_divider_un(
    .clk(clk),
    .n_rst(n_rst),
    .M(src1),
    .Q(src2),
    .parser_done(parser_done),
    .result(calc_res6),
    .alu_done(alu_done)
);
endmodule