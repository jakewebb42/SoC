`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 04:46:51 PM
// Design Name: 
// Module Name: ms_tick
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


module ms_tick(
    input logic clk,
    
    output tick
    );
  
    // Init  
    parameter milliseconds = ((1 * 100_000) - 1); // 1 millisecond = 100_000 cycles in 100 MHZ clock; -1 because count starts at 0 not 1
    logic [31:0] count, ncount;
               
    // Increase until you hit the number of desired cycles
    always_comb begin
      if (count < milliseconds)
        begin 
          ncount=count+1;
        end 
      else
        begin
          ncount=0;
        end
    end
    
    // Set Count
    always_ff @(posedge(clk)) begin
      count<=ncount; 
    end   
    
    assign tick=(count==1);
        
endmodule
