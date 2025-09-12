`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2025 04:52:49 PM
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
    input logic [15:0] SW,
    input logic CLK100MHZ,
    input logic BTNC,
    
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic CA,CB,CC,CD,CE,CF,CG
    );  

    // Counter
    logic tick;
    
    counter count_clock(
      .clk(CLK100MHZ),
      .rst(BTNC),
      .en(SW[0]),
    
      .tick(tick)    
    );

    // State Machine ----------------------------------------------------------
    logic en;
    assign en=SW[0];
    
    logic cw;
    assign cw=SW[1];
    
    logic [2:0] state;

    state sm(
      .en(en),
      .cw(cw),
      .clk(tick),
      
      .state(state)      
    );

    // Board ------------------------------------------------------------------
    board dut(
      .SW(SW),
      .clk(CLK100MHZ),
      .state(state),
    
      .LED(LED),
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)      
    );
    
endmodule
