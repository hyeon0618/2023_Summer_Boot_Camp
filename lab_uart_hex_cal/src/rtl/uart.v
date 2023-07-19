module uart (
    input clk,
    input reset,
    input [7:0] DataIn,
    input DataIn_valid,
    input uart_rx,
    output DataIn_ready,
    output [7:0] DataOut,
    output DataOut_valid,
    output uart_tx
);
    
endmodule