`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2025 07:40:50 PM
// Design Name: 
// Module Name: counter
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


module counter#(parameter N=29)(
    input logic clk,
    input logic en,
    
    output tick
    );
    
    logic [N-1:0] count, ncount;
        
    always_comb @(posedge(clk)) begin
      if (en)
        if (count < 100000) // 1 ms
          begin 
            ncount=count+1;
          end 
        else
          begin
            ncount=0;
          end
          
      else
        ncount=count;
    end
    
    assign tick=(count==1);
        
endmodule