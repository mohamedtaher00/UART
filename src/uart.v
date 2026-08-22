module uart(
    input clk,
    input rst,

    input tx_en,
    input rx_en,

    input [7:0] data_in_tx,
    input data_in_rx,

    output tx_busy, tx_done,
    output rx_busy, rx_done, rx_err,

    output data_out_tx,
    output [7:0] data_out_rx

);


    tx #(.baud_rate(9600), .clk_freq(100000000)) transmitter (
            .tx_en(tx_en),
            .rst(rst),
            .clk(clk),

            .data_in(data_in_tx),
            .data_out(data_out_tx),

            .done(tx_done),
            .busy(tx_busy)
        );


    rx receiver(
        .rx_en(rx_en),
        .clk(clk),
        .rst(rst),

        .data_in(data_in_rx),

        .data_out(data_out_rx),

        .done(rx_done),
        .busy(rx_busy),
        .err(rx_err)
    );


endmodule
