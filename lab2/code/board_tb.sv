`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 09:35:32 PM
// Design Name: 
// Module Name: state_tb
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


module board_tb;

    // Init
    logic clk;
    logic is_led_on;
    logic [6:0] sseg;
    logic [1:0] anode_index;
    
    logic [15:0] LED;
    logic [3:0] AN;
    logic CA, CB, CC, CD, CE, CF, CG;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end    
    
    // Setup
    initial begin
        anode_index=2'b11;
    end
    
    // Instantiate
    board dut(
       .clk(clk),
       .is_led_on(is_led_on),
       .sseg(sseg),
       .anode_index(anode_index),
       
       .LED(LED),
       .AN(AN),
       .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );
    
    // Test stimulus
    initial begin
      // AN 3
      is_led_on=1'b1;
      sseg=7'b1111111;
      anode_index=2'b11;
      #1000000 // wait 1 ms
      
      // AN 2
      sseg=7'b1111111;
      anode_index=2'b10;
      #1000000
      
      // AN 1
      sseg=7'b1111111;
      anode_index=2'b01;      
      #1000000
      
      // AN 0
      sseg=7'b1111111;
      anode_index=2'b00;
      #1000000 
      
      $finish;
    end  

endmodule