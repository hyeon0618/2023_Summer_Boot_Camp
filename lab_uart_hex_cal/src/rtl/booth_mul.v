module booth_mul (
    input clk,
    input n_rst,
    input [15:0] M, // multiplicant
    input [15:0] Q, // multiplier
    input parser_done,
    output reg [31:0] result,
    output alu_done
);

reg [32:0] M_33bit;
reg [32:0] Q_33bit;

reg [3:0]cnt;

wire [15:0] m_M; // minus M
wire [32:0] ADD;
wire [32:0] SUB;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 4'hf;
    else
    begin
        if(parser_done == 1'b1)
            cnt <= 4'hf;
        else
            cnt <= (cnt == 4'h0)? 4'h0 : cnt - 4'h1;
    end
always @(posedge clk or negedge n_rst)
    if(!n_rst)
        M_33bit <= 33'b0;
    else
        M_33bit <= {M, 17'b0};

assign m_M = (~M) + 16'b1;
assign ADD = Q_33bit + M_33bit;
assign SUB = Q_33bit + {m_M, 17'b0};

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        Q_33bit <= {16'b0, Q, 1'b0};
    else begin
        if((cnt > 4'h1))
            Q_33bit <= ((Q_33bit[0] == 1'b0) && (Q_33bit[1] == 1'b0))? {Q_33bit[32], Q_33bit[32:1]} :
                       ((Q_33bit[0] == 1'b0) && (Q_33bit[1] == 1'b1))? {SUB[32], SUB[32:1]} :
                       ((Q_33bit[0] == 1'b1) && (Q_33bit[1] == 1'b0))? {ADD[32], ADD[32:1]} : {Q_33bit[32], Q_33bit[32:1]};
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        result <= 32'b0;
    else
        result <= Q_33bit[32:1];

assign alu_done = (cnt == 4'h0)? 1'b1 : 1'b0;

endmodule