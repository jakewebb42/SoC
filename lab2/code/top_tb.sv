`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2025 06:54:07 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb;

    logic CLK100MHZ;
    
    logic [15:0] LED;
    logic [7:0] AN;
    logic CA, CB, CC, CD, CE, CF, CG;
    
    // Clock generation
    initial begin
        CLK100MHZ = 0;
        forever #5 CLK100MHZ = ~CLK100MHZ;
    end   
    
    // SSEG Handler
    logic [3:0] hex_out;
    logic [2:0] anode_index;
    logic tick;
    sseg_controller cont(
      .clk(CLK100MHZ),
      .en(tick),
      .hex_in(16'hf123),
      
      .anode_index(anode_index),
      .hex_out(hex_out)
    );
    
    // Hex to SSEG
    logic [6:0] sseg;   
    hex_to_sseg hts(
      .hex(hex_out),
      
     .sseg(sseg)
    );
    
    // Board
    logic is_led_on;
    assign is_led_on = 1'b1;     
  
    board dut(
      .clk(CLK100MHZ),
      .sseg(sseg),
      .is_led_on(is_led_on),
      .anode_index(anode_index),
    
      .LED(LED),
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)    
    );


    initial begin
      tick=1;
      #5 // wait 5 ns
      
      @(posedge CLK100MHZ)
      tick=1;
      #1
      tick=0;
      #19
 
      @(posedge CLK100MHZ)      
      tick=1;
      #1
      tick=0;
      #19      
      
      @(posedge CLK100MHZ)      
      tick=1;
      #1
      tick=0;
      #19
      
      @(posedge CLK100MHZ)      
      tick=1;
      #1
      tick=0;
      #19    
      
      @(posedge CLK100MHZ)      
      tick=1;
      #1
      tick=0;
      #19               
      
      @(posedge CLK100MHZ)      
      tick=1;
      #1
      tick=0;
      #19       
      
      $finish;
    end

endmodule
