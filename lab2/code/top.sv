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
    
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic CA, CB, CC, CD, CE, CF, CG
    ); 
    
    // Counter
    logic tick;
    logic en;
    assign en=1'b1;
    counter ct(
      .clk(CLK100MHZ),
      .en(en),
      
      .tick(tick)
    );
    
    // SSEG Controller
    logic [3:0] hex_out;
    logic [2:0] anode_index;
    logic [15:0] hex_in;
    assign hex_in = 16'hf123;
    
    sseg_controller sc(
      .clk(CLK100MHZ),
      .en(tick),
      .hex_in(hex_in),
      
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
      .is_led_on(is_led_on),
      .sseg(sseg),
      .anode_index(anode_index),
    
      .LED(LED),
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)    
    );
    
    
endmodule
