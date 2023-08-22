module divider_un ( // unsigned divider
    input clk,
    input n_rst,
    input [15:0] M, // Divisor
    input [15:0] Q, // Dividend
    input parser_done,
    output [31:0] result, // Remainder, Quotient
    output alu_done
);

reg [4:0] cnt;
reg [31:0] M_32bit;
reg [31:0] Q_32bit;
reg e_parser;

wire [31:0] SQ;
assign SQ = {Q_32bit[30:0], 1'b0};
wire [15:0] MM;
assign MM = (~M) + 1'b1;
wire [31:0] SQM; // SQ - M
assign SQM = SQ + {MM, 16'b0};

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 5'h0;
    else begin
        if(parser_done == 1'b0 && e_parser == 1'b1)
            cnt <= 5'h1;
        else if((cnt > 5'h0) && (cnt < 5'h10))
            cnt <= cnt + 5'h1;
        else if(cnt == 5'h10)
            cnt <= 5'h0;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        e_parser <= 1'b0;
    else
        e_parser <= parser_done;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        M_32bit <= 32'h0;
    else begin
        if(parser_done == 1'b1)
            M_32bit <= {M, 16'b0}; 
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        Q_32bit <= 32'h0;
    else begin
        if(parser_done == 1'b1)
            Q_32bit <= {16'b0, Q};
        else if((e_parser == 1'b1) || (cnt < 3'h4))
            Q_32bit <= (SQM[31] == 1'b1)? {SQ[31:1], 1'b0} : {SQM[31:1], 1'b1};
    end

wire [15:0] Quo;
wire [15:0] Rem;
assign result = (cnt == 5'h10)? Q_32bit : 32'h0;
assign Quo = (cnt == 5'h10)? Q_32bit[15:0] : 16'b0;
assign Rem = (cnt == 3'h4)? Q_32bit[31:16] : 16'b0;
assign alu_done = (cnt == 5'h10)? 1'b1 : 1'b0;

endmodule