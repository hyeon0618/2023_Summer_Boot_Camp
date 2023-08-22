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
wire [31:0] Q1;

reg [4:0] cnt;

wire [31:0] plus;
wire [31:0] plus_Q1;
assign plus = Q_32bit + M_32bit;
assign Q1 = (cnt == 1'b0)? {16'b0, Q} : 32'b0;
assign plus_Q1 = Q1 + M_32bit;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 5'h0;
    else begin
        if(parser_done == 1'b1)
            cnt <= 5'h1;
        else if((cnt > 5'h0) && (cnt < 5'h10))
            cnt <= cnt + 5'h1;
        else if(cnt == 5'h10)
            cnt <= 5'h0;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        M_32bit <= 32'h0;
    else begin
        if(cnt == 5'b0)
            M_32bit <= {M, 16'b0};
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        Q_32bit <= 32'h0;
    else begin
        if(cnt == 5'h0)
            Q_32bit <= (Q1[0] == 1'b1)? {1'b0, plus_Q1[31:1]} : {1'b0, Q1[31:1]}; 
            //Q_32bit <= {16'b0, Q[15:0]};
        else if((cnt > 5'h0) && (cnt <= 5'h10))
            Q_32bit <= (Q_32bit[0] == 1'b1)? {1'b0, plus[31:1]} : {1'b0, Q_32bit[31:1]};
    end

assign result = (cnt == 5'h10)? Q_32bit : 32'h0;
assign alu_done = (cnt == 5'h10)? 1'b1 : 1'b0;

endmodule