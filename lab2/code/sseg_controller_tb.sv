`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2025 05:55:54 PM
// Design Name: 
// Module Name: sseg_controller_tb
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


module sseg_controller_tb;

    logic [15:0] hex_in;
    logic clk;
    
    logic [2:0] anode_index;
    logic [3:0] hex_out;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end    

    // Counter
    logic tick;

    // Controller
    sseg_controller dut(
      .clk(tick),
      .hex_in(hex_in),
      
      .anode_index(anode_index),
      .hex_out(hex_out)
    );

    
    initial begin
      // AN 3
      tick=0;
      hex_in=16'hf123;
      anode_index=3'b011;
      #15 // wait 10 ns
      
      @(posedge(clk))
      tick=1;
      #1
      tick=0;
      #9
      
      tick=1;
      #1
      tick=0;
      #9      
      
      tick=1;
      #1
      tick=0;
      #9
      
      tick=1;
      #1
      tick=0;
      #9    
      
      tick=1;
      #1
      tick=0;
      #9               
      
      tick=1;
      #1
      tick=0;
      #9       
      
      $finish;
    end

endmodule
