`timescale 1us/1ns

module rx_tb ; 

    reg rx_en_tb ;
    reg clk_tb ;
    reg rst_tb ;

    reg data_in_tb ;

    wire [7:0] data_out_tb ;

    rx DUT (.rx_en(rx_en_tb), .clk(clk_tb), .rst(rst_tb), .data_in(data_in_tb), .data_out(data_out_tb)) ;


    task derive ;
        input rx_en ;
        input rst ;
        input data_in ;
        begin 
            rx_en_tb = rx_en  ;
            rst_tb = rst ;
            data_in_tb = data_in ;
            #(104.180) ;

        end 
        
        endtask

    initial clk_tb = 0 ;
    always #(0.005) clk_tb = ~clk_tb;

    initial begin 

        $dumpfile("dump.vcd");
        $dumpvars(0, rx_tb);
        derive(1'b0, 1'b0, 1'b1) ;
        //start bit + data
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b1) ;
        //stop bit 
        derive(1'b1, 1'b0, 1'b1) ;

        #(10) derive(1'b0, 1'b1, 1'b0) ; //reset 


        derive(1'b0, 1'b0, 1'b1) ;
        //start bit + data
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        //stop bit 
        derive(1'b1, 1'b0, 1'b1) ;

        //assume we send invalid frame w/ stop bit of 0 

        //start bit + data
        derive(1'b1, 1'b0, 1'b0) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        derive(1'b1, 1'b0, 1'b1) ;
        //stop bit 
        derive(1'b1, 1'b0, 1'b0) ;

        
        $finish ;



    end 




endmodule 
