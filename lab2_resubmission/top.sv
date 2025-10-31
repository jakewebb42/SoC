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

    output logic [7:0] AN,
    output logic CA, CB, CC, CD, CE, CF, CG
    );

    // State
    logic [31:0] number;
    assign number = 1032;
    
//    state jw_state(
//      .number(number)
//    );

    // Board
    board jw_board(
      .CLK100MHZ(CLK100MHZ),
      .number(number),
      
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );
    
endmodule
