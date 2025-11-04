`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 02:31:25 PM
// Design Name: 
// Module Name: anode_counter
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


module anode_counter#(parameter N = 32)(
    input logic clk,
    input logic rst,
    input logic en,
    
    output tick
    );
  
    // Init  
    parameter milliseconds = ((/*0.25 * 100_000*/25_000) - 1); // 1 millisecond = 100_000 cycles in 100 MHZ clock; -1 because count starts at 0 not 1
    logic [N-1:0] count, ncount;
    
    // If reset, set count to 0
    always_ff @(posedge(clk), posedge(rst))
      if (rst)
        count<=0;
      else
        count<=ncount;
        
    // Increase until you hit the number of desired cycles
    always_comb begin
      if (en)
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
    
    assign tick=(count==1);
        
endmodule
