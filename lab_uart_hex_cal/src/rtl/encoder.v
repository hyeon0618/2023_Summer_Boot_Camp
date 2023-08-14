module encoder (
    input clk,
    input n_rst,
    input alu_done,
    input [31:0] cal_res,
    output reg [7:0] uart_out,
    output uout_valid
);

reg [3:0] cnt;
reg [7:0] cal_data;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cnt <= 4'h0;
    else begin
        if((cnt == 4'h0) && (alu_done == 1'b1))
            cnt <= cnt + 4'h1;
        else if((cnt > 4'h0) && (cnt < 4'h8))
            cnt <= cnt + 4'h1;
        else if(cnt == 4'h8)
            cnt <= 4'h0;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        cal_data = 8'h0;
    else begin
        if((cnt == 4'h0) && (alu_done == 1'b1))
            cal_data <= {4'b0, cal_res[3:0]};
        else if(cnt == 4'h1)
            cal_data <= {4'b0, cal_res[7:4]};
        else if(cnt == 4'h2)
            cal_data <= {4'b0, cal_res[11:8]};
        else if(cnt == 4'h3)
            cal_data <= {4'b0, cal_res[15:12]};
        else if(cnt == 4'h4)
            cal_data <= {4'b0, cal_res[19:16]};
        else if(cnt == 4'h5)
            cal_data <= {4'b0, cal_res[23:20]};
        else if(cnt == 4'h6)
            cal_data <= {4'b0, cal_res[27:24]};
        else if(cnt == 4'h7)
            cal_data <= {4'b0, cal_res[31:28]};
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        uart_out <= 8'h0;
    else begin
        if(cal_data == 8'h0)
            uart_out <= 8'h30;
        else if(cal_data == 8'h1)
            uart_out <= 8'h31;
        else if(cal_data == 8'h2)
            uart_out <= 8'h32;
        else if(cal_data == 8'h3)
            uart_out <= 8'h33;
        else if(cal_data == 8'h4)
            uart_out <= 8'h34;
        else if(cal_data == 8'h5)
            uart_out <= 8'h35;
        else if(cal_data == 8'h6)
            uart_out <= 8'h36;
        else if(cal_data == 8'h7)
            uart_out <= 8'h37;
        else if(cal_data == 8'h8)
            uart_out <= 8'h38;
        else if(cal_data == 8'h9)
            uart_out <= 8'h39;
        else if(cal_data == 8'hA)
            uart_out <= 8'h41;
        else if(cal_data == 8'hB)
            uart_out <= 8'h42;
        else if(cal_data == 8'hC)
            uart_out <= 8'h43;
        else if(cal_data == 8'hD)
            uart_out <= 8'h44;
        else if(cal_data == 8'hE)
            uart_out <= 8'h45;
        else if(cal_data == 8'hF)
            uart_out <= 8'h46;       
    end

assign uout_valid = (cnt == 4'h8)? 1'b1 : 1'b0;

endmodule