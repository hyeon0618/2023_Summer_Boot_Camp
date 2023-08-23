module decoder (
    input clk,
    input n_rst,
    input [7:0] data,
    input dout_valid,
    output reg format,
    output reg [3:0] data_type,
    output reg [4:0] operator,
    output reg parser_done,
    output reg [15:0] src1, src2
);

reg op_s; // operator input signal
reg n_dout_val;
reg n_equal;


always @(posedge clk or negedge n_rst)
    if(!n_rst)
        n_dout_val <= 1'b0;
    else
        n_dout_val <= dout_valid;


always @(posedge clk or negedge n_rst)
    if(!n_rst)
        data_type <= 4'b0;
    else begin
        if(dout_valid == 1'b1)
            data_type <= (data == 8'h53)? 4'h1 : // Signed
                         (data == 8'h55)? 4'h2 : data_type; // Unsigned
    end
    
always @(posedge clk or negedge n_rst)
    if(!n_rst)
        format <= 1'b0;
    else
        format <= (data == 8'h49)? 1'b1 : format; // Integer

reg space_bar;
always @(posedge clk or negedge n_rst)
    if(!n_rst)
        space_bar <= 1'b0;
    else
        space_bar <= (data == 8'h20)? 1'b1: 1'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        operator <= 5'h0;
    else begin
        if(dout_valid == 1'b1)
            operator <= (data == 8'h2B)? 5'h01 : // +
                        (data == 8'h2D)? 5'h02 : // -
                        (data == 8'h2A)? 5'h03 : // *
                        (data == 8'h2F)? 5'h04 : operator; // /
    end



wire equal;
assign equal = (data == 8'h3D)? 1'b1 : 1'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        n_equal <= 1'b0;
    else
        n_equal <= (equal == 1'b1)? 1'b1 : 1'b0;

// if data is +, -, * or /, op_s is 1'b1
always @(posedge clk or negedge n_rst)
    if(!n_rst)
        op_s <= 1'b0;
    else if((data == 8'h2B) | (data == 8'h2D) | (data == 8'h2A) | (data == 8'h2F))
        op_s <= (parser_done == 1'b0)? 1'b1: 1'b0;
    else if(data == 8'h3D)
        op_s <= 1'b0;

reg [15:0] src, src0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        src <= 16'h0;
    else begin
        if((dout_valid == 1'b1) && (op_s == 1'b0))
            src <= (data == 8'h30)? 16'h0 : // 0
                    (data == 8'h31)? 16'h1 : // 1
                    (data == 8'h32)? 16'h2 : // 2
                    (data == 8'h33)? 16'h3 : // 3
                    (data == 8'h34)? 16'h4 : // 4
                    (data == 8'h35)? 16'h5 : // 5
                    (data == 8'h36)? 16'h6 : // 6
                    (data == 8'h37)? 16'h7 : // 7
                    (data == 8'h38)? 16'h8 : // 8
                    (data == 8'h39)? 16'h9 : // 9
                    (data == 8'h41)? 16'hA : // A
                    (data == 8'h42)? 16'hB : // B
                    (data == 8'h43)? 16'hC : // C
                    (data == 8'h44)? 16'hD : // D
                    (data == 8'h45)? 16'hE : // E
                    (data == 8'h46)? 16'hF : src; // F
        else if(dout_valid == 1'b0)
            src <= 16'h0;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        src1 <= 16'h0;
    else begin
        if((n_dout_val == 1'b1) && (op_s == 1'b0) && (parser_done == 1'b0))
            src1 <= {src1[11:0], src[3:0]};
        /*else if(dout_valid == 1'b0)
            src1 <= 16'h0;*/
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        src0 <= 16'h0;
    else begin
        if((dout_valid == 1'b1) && (op_s == 1'b1))
            src0 <= (data == 8'h30)? 16'h0 : // 0
                    (data == 8'h31)? 16'h1 : // 1
                    (data == 8'h32)? 16'h2 : // 2
                    (data == 8'h33)? 16'h3 : // 3
                    (data == 8'h34)? 16'h4 : // 4
                    (data == 8'h35)? 16'h5 : // 5
                    (data == 8'h36)? 16'h6 : // 6
                    (data == 8'h37)? 16'h7 : // 7
                    (data == 8'h38)? 16'h8 : // 8
                    (data == 8'h39)? 16'h9 : // 9
                    (data == 8'h41)? 16'hA : // A
                    (data == 8'h42)? 16'hB : // B
                    (data == 8'h43)? 16'hC : // C
                    (data == 8'h44)? 16'hD : // D
                    (data == 8'h45)? 16'hE : // E
                    (data == 8'h46)? 16'hF : src0; // F
        else if(dout_valid == 1'b0)
            src0 <= 16'h0;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        src2 <= 16'h0;
    else begin
        if((n_dout_val == 1'b1) && (op_s == 1'b1))
            src2 <= {src2[11:0], src0[3:0]};
        /*else if(dout_valid == 1'b0)
            src2 <= 16'h0;*/
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        parser_done <= 1'b0;
    else begin
        if(equal == 1'b1 && n_equal == 1'b0)
            // if operator is '=', parser_done is 1'b1
            parser_done <= 1'b1;
        else
            parser_done <= 1'b0;
    end
    
endmodule