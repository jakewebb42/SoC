`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 04:55:56 PM
// Design Name: 
// Module Name: ms_count_tb
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


module ms_count_tb;

    // Counter
    logic clk;
    logic tick;   
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end       
    
    // ms Tick
    ms_tick jw_mst1(
     .clk(clk),
    
     .tick(tick)
    );    

    // ms Counter 
    logic [31:0] ms_passed;   
    
    ms_counter jw_msc1(
      .clk(clk),
      .tick_in(tick),
      .en(1),
      .rst(0),
      
      .ms_passed(ms_passed)
    );

    // Testbench
    initial begin
      #500000 $finish;
     end    

endmodule
