module booth_mul (
    input clk,
    input n_rst,
    input [3:0] multiplicant,
    input [3:0] multiplier,
    input start,
    input fin,
    output [7:0] product //result
);

reg [8:0] A; //9bit [3:0] multiplicant 0000 0
reg [8:0] M; //9bit [3:0] 2'th compliment multiplicant 0000 0
reg [8:0] P; //9bit 0000 [3:0]multiplier 0

reg [2:0] cnt;
reg [2:0] n_cnt;
wire [8:0] PA;
wire [8:0] PM;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        A <= 9'h0;
    else
        A <= {multiplicant, 5'b0000_0};

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        M <= 9'h0;
    else
        M <= {~multiplicant + 1'b1, 5'b0000_0};

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 3'h0;
    else begin
        if(start == 1'b1)
            cnt <= (cnt < 3'h4)? cnt + 1'b1 : 3'h1;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        n_cnt <= 3'h0;
    else
        n_cnt <= cnt;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        P <= {4'b0000, multiplier, 1'b0};
    else begin
        if(fin == 1'b1)
            P <= P;
        else if((P[0] == 1'b0 && P[1] == 1'b0) && (cnt > 3'h0))
            P <= {P[8], P[8:1]};
        else if((P[0] == 1'b1 && P[1] == 1'b1) && (cnt > 3'h0))
            P <= {P[8], P[8:1]};
        else if((P[0] == 1'b1 && P[1] == 1'b0) && (cnt > 3'h0)) begin
            P <= {PA[8], PA[8:1]};
        end
        else if((P[0] == 1'b0 && P[1] == 1'b1) && (cnt > 3'h0)) begin
            P <= {PM[8], PM[8:1]};
        end
        else if(cnt == 3'h1) begin
            P <= {4'b0000, multiplier, 1'b0};
        end
    end

assign PA = P + A;
assign PM = P + M;

assign product = P[8:1];

endmodule