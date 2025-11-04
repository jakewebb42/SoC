`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2025 03:33:50 PM
// Design Name: 
// Module Name: prbs_lfsr
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


module prbs_lfsr(
    input logic clk,
    input logic rst,
    
    output logic rnd
    );
    
    // 2^34 -> 17,000,000,000 nanoseconds = 17 seconds
    // Shift Register
    parameter START = 14'b10000000_000000;
    logic [13:0] count, ncount;
    
    // Reset
    always_ff @(posedge(clk), posedge(rst))
      if(rst)
          count <= START;
      else
          count <= ncount;
    
    // Build prbs sequence
    logic feedback;
    assign feedback = count[13]^count[12]^count[10]^count[8];  
      
    assign ncount[13:1] = count[12:0];
    assign ncount[0] =  feedback;
    
    assign rnd = count[0];
endmodule
