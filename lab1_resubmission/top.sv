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
    input logic [1:0] SW,
    input logic CLK100MHZ,
    input logic BTNC,
    
    output logic [1:0] LED,
    output logic [7:0] AN,
    output logic CA,CB,CC,CD,CE,CF,CG
    );  

    // Counter  ---------------------------------------------------------------
    logic en;
    assign en = SW[0];
    
    logic tick;
    
    counter count_clock(
      .clk(CLK100MHZ),
      .rst(BTNC),
      .en(en),
    
      .tick(tick)    
    );

    // State Machine ----------------------------------------------------------
    logic cw;
    assign cw = SW[1];
    
    logic [2:0] state;

    state sm(
      .clk(CLK100MHZ),
      .en(tick),
      .cw(cw),
      
      .state(state)      
    );

    // Board ------------------------------------------------------------------
    assign LED[0] = en; // en
    assign LED[1] = cw; // cw
    
    board dut(
      .clk(CLK100MHZ),
      .state(state),

      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)      
    );
    
endmodule
