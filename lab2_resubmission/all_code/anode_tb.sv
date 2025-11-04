`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 02:32:31 PM
// Design Name: 
// Module Name: anode_tb
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


module anode_tb;

    // Counter
    logic clk;
    logic tick;   
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end       
    
    anode_counter jw_oc(
     .clk(clk),
     .rst(0),
     .en(1),
    
     .tick(tick)
    );    

    // Anode Handler    
    logic [1:0] anode_index;   
    
    anode_handler jw_ah(
      .clk(clk),
      .en(tick),
      
      .anode_index(anode_index)
    );

    // Testbench
    initial begin
      #500 $finish;
     end      

endmodule
