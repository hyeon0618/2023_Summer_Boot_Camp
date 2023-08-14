module tx (
    input clk,
    input n_rst,
    input [7:0] tx_data,
    input uin_valid,
    output reg TXD
);

reg [8:0] baud_cnt; // baud rate = 115200, 50MHz, 434 count
reg [3:0] tx_cnt;
reg [7:0] data;
wire txen;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        baud_cnt <= 9'h0;
    else
        baud_cnt <= (baud_cnt != 9'h1B2)? baud_cnt + 9'b1 : 9'h0;

assign txen = (baud_cnt == 9'h1B2)? 1'b1 : 1'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        tx_cnt <= 4'h0;
    else if((uin_valid == 1'b1) && (tx_cnt == 4'b0) && txen == 1'b1)
        tx_cnt <= tx_cnt + 4'b1;
    else if((tx_cnt >= 4'b1) && (tx_cnt < 4'hA) && (txen == 1'b1))
        tx_cnt <= tx_cnt + 4'b1;
    else if((tx_cnt == 4'hA) && (txen == 1'b1))
        tx_cnt <= 4'h0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        data <= 8'h0;
    else begin
        if((tx_cnt > 4'h1) && (tx_cnt < 4'hA) && (txen == 1'b1))
            data <= {1'b0, data[7:1]};
        else if(tx_cnt == 4'h0)
            data <= tx_data;
    end

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        TXD <= 1'b1;
    else begin
        if(txen == 1'b1) begin // start
            if(tx_cnt == 4'h1)
                TXD <= 1'b0;
            else if((tx_cnt >= 4'h2) && (tx_cnt < 4'hA)) // LSB ~ MSB
                TXD <= data[0];
            else if(tx_cnt == 4'hA) // STOP
                TXD <= 1'b1;
        end
    end
// no include parity bit

endmodule