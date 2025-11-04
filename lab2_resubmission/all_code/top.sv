`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 01:56:25 PM
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
    input logic BTNC, BTNL, BTNR,

    output logic [7:0] AN,
    output logic CA, CB, CC, CD, CE, CF, CG,
    output logic LED[1:0]
    );

    // State
    logic [31:0] number;
    
    game jw_game(
       .CLK100MHZ(CLK100MHZ),
       .btn_start(BTNL),
       .btn_stop(BTNC),
       .btn_clear(BTNR),
     
       .LED(LED[0]),
       .number(number)
    );
    assign LED[1] = 0;

    // Board
    board jw_board(
      .CLK100MHZ(CLK100MHZ),
      .number(number),
      
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );
    
endmodule
