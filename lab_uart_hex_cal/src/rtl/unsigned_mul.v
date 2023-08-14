module unsigned_mul (
    input clk,
    input n_rst,
    input [15:0] M, // multipicand
    input [15:0] Q, // multiplier
    input parser_done,
    output [31:0] result,
    output alu_done
);

reg [31:0] M_32bit;
reg [31:0] Q_32bit;

reg [4:0] cnt;

wire [31:0] plus;
assign plus = Q_32bit + M_32bit;

reg sig_prev;
wire e_parser_done;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 4'h0;
    else
    begin
        if(e_parser_done == 1'b1)
            cnt <= 4'h0;
        else if(cnt == 4'h0 && parser_done == 1'b1)
            cnt <= cnt + 4'h1;
        else
            cnt <= ((cnt == 4'hF) && (cnt > 4'h0))? cnt : cnt + 4'h1;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        M_32bit <= 32'h0;
    else if(parser_done == 1'b1)
        M_32bit <= {M, 16'b0};

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        Q_32bit <= 32'h0;
    else begin
        if(parser_done == 1'b1)
            Q_32bit <= {16'b0, Q};
        else if((cnt < 4'hF))
            Q_32bit <= (Q_32bit[0] == 1'b1)? {1'b0, plus[31:1]} : {1'b0, Q_32bit[31:1]};
    end

assign result = Q_32bit;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        sig_prev <= 1'b0;
    else
        sig_prev <= parser_done;

assign e_parser_done = ~parser_done & sig_prev;

assign alu_done = (cnt == 4'hF)? 1'b1 : 1'b0;

endmodule