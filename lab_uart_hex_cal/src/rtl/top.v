module top(
    input clk,
    input n_rst,
    input RXD,
    output TXD
);

wire [7:0] data;
wire dataout_valid;
wire [3:0] dtype;
wire [4:0] operator;
wire parser_done;
wire [15:0] src1;
wire [15:0] src2;
wire alu_done;
wire [31:0] calc_res;

rx u_rx(
    .clk(clk),
    .n_rst(n_rst),
    .RXD(RXD),
    .Dataout(data),
    .Dataout_valid(dataout_valid)
);

tx u_tx(
    .clk(clk),
    .n_rst(n_rst),
    .tx_data(data),
    .uin_valid(dataout_valid),
    .TXD(TXD)
);

decoder u_decoder(
    .clk(clk),
    .n_rst(n_rst),
    .data(data),
    .dout_valid(dataout_valid),
    .format(),
    .data_type(dtype),
    .operator(operator),
    .parser_done(parser_done),
    .src1(src1),
    .src2(src2)
);

alu u_alu(
    .clk(clk),
    .n_rst(n_rst),
    .dtype(dtype),
    .operator(operator),
    .parser_done(parser_done),
    .src1(src1), 
    .src2(src2),
    .format(),
    .alu_done(alu_done),
    .calc_res(calc_res)
);

endmodule