`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2025 11:44:34 AM
// Design Name: 
// Module Name: top
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


module top(
    input logic CLK100MHZ,
    input logic BTNL, BTNC, BTNR,
    
    output logic [15:0] LED,
    output logic [3:0] AN,
    output logic CA, CB, CC, CD, CE, CF, CG
    );
    
    // Counter
    logic tick;
    logic en= 1'b1;
    
    counter(
      .clk(CLK100MHZ),
      .en(en),
    
      .tick(tick)    
    );
    
    // Hex to SSEG
    logic [6:0] sseg;
    hex_to_sseg(
      .hex(hex),
      
     .sseg(sseg) 
    );
    
    // Board
    logic is_led_on;
    assign is_led_on = 1'b1;    
    
    board dut(
      .clk(tick),
      .BTNL(BTNL), .BTNC(BTNC), .BTNR(BTNR), // temporary
      .sseg(sseg),
      .is_led_on(is_led_on),
      .anode_index(anode_index),
    
      .LED(LED),
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)    
    );
    
    
endmodule
