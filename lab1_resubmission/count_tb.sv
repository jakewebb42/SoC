`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 09:45:09 AM
// Design Name: 
// Module Name: count_tb
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


module count_tb;

    // Inputs
    logic clk;
    logic rst;
    logic en;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end   
       
    // Output
    logic tick;
    
    // Instantiate
    counter c(
      .clk(clk),
      .rst(rst),
      .en(en),
      
      .tick(tick)
    );
    
    // TB
    initial begin
      rst = 1; 
      en = 0;
      
      #5
      rst = 0;
      en = 1;

      // Cycle 2 - Pause
      #200 @(posedge clk);
      en = 0;

      // Cycle 3 - Run CW
      #100 @(posedge clk);
      en=1;

      // Finish simulation
      #200 $finish;
     end  

endmodule
