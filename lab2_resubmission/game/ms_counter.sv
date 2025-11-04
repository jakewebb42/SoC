`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 04:49:03 PM
// Design Name: 
// Module Name: ms_counter
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

module ms_counter(
    input logic clk,
    input logic tick_in,
    input logic rst,
    input logic en,
    
    output [31:0] ms_passed
    );
  
    // Init  
    parameter milliseconds = ((1000) - 1); // Tick in happens every millisecond. We want to count to 1000 ms
    logic [31:0] count, ncount;
    
    // If reset, set count to 0
    always_ff @(posedge(clk), posedge(rst))
      if (rst)
        count<=0;
      else
        count<=ncount;
        
    // Increase until you hit the number of desired cycles
    always_comb begin
      if (en && tick_in)
       begin
        if (count < milliseconds)
          begin 
            ncount=count+1;
          end 
        else
          begin
            ncount=0;
          end
       end // if en 
        
      else // if not en
        ncount=count;
    end
    
    assign ms_passed=count;
    
endmodule
