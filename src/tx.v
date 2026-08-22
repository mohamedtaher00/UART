module tx #(parameter baud_rate = 9600, parameter clk_freq = 100000000) (
    input tx_en,
    input rst,
    input clk,

    input[7:0] data_in,
    output reg data_out,
    output reg done = 1'b0 ,
    output busy
);
    //parameter baud_period = 104; // baud_period = T * (comparison + 1) -> comparison = (baud_period/T) - 1 = (clk_freq./baud_rate) - 1
    reg[31:0] baud_count = 0;
    reg[3:0] baud_tick = 0 ;
    wire [7:0] data_in_tx;

    assign data_in_tx = data_in ;

    localparam baud_threshold = (clk_freq/baud_rate) - 1 ;
    //baud counter -> to derive baud rate from the system's clock
    always @(posedge clk) begin
        if(rst) begin
            baud_count <= 0 ;
            baud_tick <= 0 ;
            done <= 1'b0 ;
        end
        else if (tx_en) begin
            //can we assert the busy flag here?
            if (baud_count == baud_threshold ) begin // the driven baud period
                if(baud_tick == 4'h9) begin
                    baud_count <= 0 ;
                    done <= 1'b1 ;
                    baud_tick <= 4'h0 ;
                end
                else begin
                    done <= 1'b0;
                    baud_count <= 0 ;
                    baud_tick <= baud_tick + 1'b1 ;
                end
            end

            else begin
                baud_count <= baud_count + 1 ;
            end
        end

    end

    // those baud ticks will control the process of sending
    always @(*) begin
         if(tx_en) begin
            case(baud_tick)

            4'h0 : data_out = 1'b0; // start bit
            //data
            4'h1 : data_out = data_in_tx[0] ;
            4'h2 : data_out = data_in_tx[1] ;
            4'h3 : data_out = data_in_tx[2] ;
            4'h4 : data_out = data_in_tx[3] ;
            4'h5 : data_out = data_in_tx[4] ;
            4'h6 : data_out = data_in_tx[5] ;
            4'h7 : data_out = data_in_tx[6] ;
            4'h8 : data_out = data_in_tx[7] ;
            //end bit
            4'h9 : begin
                data_out = 1'b1 ;
            end
            default : data_out = 1'b1 ;
            endcase
        end
        else begin
            data_out = 1'b1 ;
        end
    end

    assign busy = tx_en && !done;

endmodule
