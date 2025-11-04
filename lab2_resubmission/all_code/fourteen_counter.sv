`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2025 03:40:28 PM
// Design Name: 
// Module Name: fourteen_counter
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


module fourteen_counter(
    input logic clk,
    input logic en,
    input logic rst,
    
    output logic [3:0] count_out
    );
    
  
    // Init  
    logic [3:0] count, ncount;
    
    
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
        if (count < 13)
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
    
    assign count_out=count;
endmodule
