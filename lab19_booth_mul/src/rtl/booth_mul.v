module booth_mul (
    input clk,
    input n_rst,
    input [3:0] multiplicant,
    input [3:0] multiplier,
    output reg [7:0] product //result
);

reg [8:0] A; //9bit [3:0] multiplicant 0000 0
reg [8:0] M; //9bit [3:0] 2'th compliment multiplicant 0000 0
reg [8:0] P; //9bit 0000 [3:0]multiplier 0

reg [2:0] cnt;
reg fin;
reg prev_fin;
wire e_fin;
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
    else
        cnt <= (cnt < 3'h4)? cnt + 1'b1 : 3'h1;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        fin <= 1'b0;
    else
        fin <= (cnt == 3'h4)? 1'b1 : 1'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        prev_fin <= 1'b0;
    else
        prev_fin <= fin;

assign e_fin = fin & ~prev_fin;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        P <= {4'b0000, multiplier, 1'b0};
    else begin
        if(e_fin)
            P <= P;
        else if((P[0] == 1'b0 && P[1] == 1'b0))
            P <= {P[8], P[8:1]};
        else if((P[0] == 1'b1 && P[1] == 1'b1))
            P <= {P[8], P[8:1]};
        else if((P[0] == 1'b1 && P[1] == 1'b0)) begin
            P <= {PA[8], PA[8:1]};
        end
        else if((P[0] == 1'b0 && P[1] == 1'b1)) begin
            P <= {PM[8], PM[8:1]};
        end
    end

assign PA = P + A;
assign PM = P + M;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        product <= 8'h0;
    else
        product <= P[8:1];


endmodule