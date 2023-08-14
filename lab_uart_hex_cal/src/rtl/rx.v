module rx (
    input clk,
    input n_rst,
    input RXD,

    output reg [7:0] Dataout,
    output Dataout_valid
);

reg [8:0] baud_cnt;
wire rxen;
reg [3:0] rx_cnt;

wire rx_valid;

assign rx_valid = ((RXD == 1'b0) && (rx_cnt == 4'h0))? 1'b1 : 1'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        baud_cnt <= 9'h0;
    else
        baud_cnt <= (baud_cnt != 9'h1B2)? baud_cnt + 9'b1 : 9'h0;

assign rxen = (baud_cnt == 9'h1B2)? 1'b1 : 1'b0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        rx_cnt <= 4'h0;
    else if((rx_valid == 1'b1) && (rxen == 1'b1))
        rx_cnt <= rx_cnt + 4'b1;
    else if((rx_cnt >= 4'b1) && (rx_cnt < 4'hA) && (rxen == 1'b1))
        rx_cnt <= rx_cnt + 4'b1;
    else if((rx_cnt == 4'hA) && (rxen == 1'b1))
        rx_cnt <= 4'h0;

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        Dataout <= 8'h0;
    else begin
        if(rxen == 1'b1) begin
            if(rx_cnt == 4'h0)
                Dataout <= 8'h0;
            else if((rx_cnt > 4'h0) && (rx_cnt < 4'hA))
                Dataout <= {RXD, Dataout[7:1]};
            else if(rx_cnt == 4'hA)
                Dataout <= Dataout;
        end
    end

assign Dataout_valid = (rx_cnt == 4'hA)? 1'b1 : 1'b0;


endmodule