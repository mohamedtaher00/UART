`timescale 1us/1ns

module tx_tb ;

    reg clk_tb ;
    reg tx_en_tb ;
    reg[7:0] data_in_tb ;
    reg rst_tb ;

    wire[7:0] data_out_tb ;

    tx DUT (.clk(clk_tb), .rst(rst_tb), .data_in(data_in_tb), .tx_en(tx_en_tb), .data_out(data_out_tb)) ;

    task derive ;
        input tx_en ;
        input rst ;
        input[7:0] data_in ;
        begin 
            tx_en_tb = tx_en  ;
            rst_tb = rst ;
            data_in_tb = data_in ;

        end 

    endtask 
    initial clk_tb = 0 ;
    always #(0.005) clk_tb = ~clk_tb;

    initial begin 

        $dumpfile("dump.vcd");
        $dumpvars(0, tx_tb);
 
        derive(1'b0, 1'b0, 8'h00) ;
        #(1) ;
        derive(1'b1, 1'b0, 8'hAA) ;
        #(1050) ;
        derive(1'b0, 1'b1, 8'h00) ; //reset
        #(10)
        derive(1'b1, 1'b1, 8'hff) ;
        #(1050) ;
        derive(1'b0, 1'b1, 8'h00) ; //reset
        #(10) 
        derive(1'b1, 1'b0, 8'b1010_0101) ;
        #(1100)

        $finish;

    end 



endmodule