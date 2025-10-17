`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 07:57:39 PM
// Design Name: 
// Module Name: led_blink_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_blink_tb();

    logic clk;
    logic reset;
    // slot interface
    logic cs;
    logic read;
    logic write;
    logic [4:0] addr;
    logic [31:0] wr_data;
    logic [31:0] rd_data;
    // external port    
    logic [3:0] dout;
    
    led_blink test(
      .clk(clk),
      .reset(reset),
      
      .cs(cs),
      .read(read),
      .write(write),
      .addr(addr),
      .wr_data(wr_data),
      .rd_data(rd_data),
      
      .dout(dout) 
    );
    
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end    
    
    initial begin
        cs = 1;
        write = 1;
        addr = 0;
        wr_data = 16'h01;
        
        #10
        addr = 1;
        wr_data = 16'h02;
        
        #10
        addr = 2;
        wr_data = 16'h01;
        
        #10
        addr = 3;
        wr_data = 16'h02;
        
        #500_000_000 $finish;    
    end    

endmodule
