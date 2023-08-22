module divider (
    input clk,
    input n_rst,
    input [15:0] M, // Divisor
    input [15:0] Q, // Dividend
    input parser_done,
    output [31:0] result, // Remainder, Quotient
    output alu_done
);
reg [4:0] cnt;
reg [15:0] A;
reg [15:0] SQ; //shift Q & Quotient

reg e_parser;
always @(posedge clk or negedge n_rst)
    if(!n_rst)
        e_parser <= 1'b0;
    else
        e_parser <= parser_done;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 5'h0;
    else begin
        if(parser_done == 1'b0 && e_parser == 1'b1)
            cnt <= 5'h1;
        else if((cnt > 5'h0) && (cnt < 3'h10))
            cnt <= cnt + 5'h1;
        else if(cnt == 5'h10)
            cnt <= 5'h0;
    end

wire [5:0] SA; // shift A
assign SA = (e_parser == 1'b0 && parser_done == 1'b1)? {A[14:0], Q[15]} :
            (e_parser == 1'b1) ? {A[14:0], SQ[14]} :
            ((cnt > 5'h0) && (cnt < 5'h10))? {A[14:0], SQ[14]} : A;


wire [15:0] APM;
assign APM = SA + M;
wire [15:0] AMM;
assign AMM = SA + ((~M) + 1'b1);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        A <= 16'h0;
    else begin
        if(parser_done == 1'b1)
            A <=AMM;
        else if(e_parser == 1'b1)
            A <= (A[15] == 1'b1)? APM : AMM;
        else if(((cnt > 5'h0) && (cnt < 5'h10)))
            A <= (A[15] == 1'b1)? APM : AMM;
        else if(cnt == 3'h6)
            A <= (A[15] == 1'b1)? A + M : A;
        else if(cnt == 5'h0)
            A <= 16'h0;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        SQ <= 16'h0;
    else begin
        if(e_parser == 1'b1)
            SQ <= (A[15] == 1'b1)? {Q[14:0], 1'b0} : {Q[14:0], 1'b1};
        else if(cnt > 3'h0)
            SQ <= (A[15] == 1'b1)? {SQ[14:0], 1'b0} : {SQ[14:0], 1'b1};
        else if(cnt == 5'h0)
            SQ <= 16'h0;
    end

wire [15:0] A1;
assign A1 = (cnt == 5'h10)? A + M : 16'h0;
assign result = (cnt == 5'h10)? {A1, SQ} : 32'h0;
assign alu_done = (cnt == 5'h10)? 1'b1 : 1'b0;

endmodule