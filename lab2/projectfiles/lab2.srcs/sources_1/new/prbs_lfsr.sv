`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2025 10:19:25 AM
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

module prbs_lfsr#(parameter N=4)(
    input logic clk,
    input logic rst,
    output logic rnd
    );
    
    // 2^34 -> 17,000,000,000 nanoseconds = 17 seconds
    
    
    // Shift Register
    parameter START = { {(N-1){1'b0}} , 1'b1 };
    logic [N-1:0] count, ncount;
    
    always_ff @(posedge(clk), posedge(rst))
      if(rst)
          count <= START;
      else
          count <= ncount;
    
    // Build prbs sequence
    logic feedback;
    assign feedback = count[3]^count[2];    
    assign ncount = { count[2:0] , feedback };
    
    assign rnd = count[3];
    
endmodule
