`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 05:00:52 PM
// Design Name: 
// Module Name: rand_counter
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


module rand_counter(
    input logic clk,
    input logic [13:0] rand_ms,
    input logic en,
    input logic rst,
    
    output logic tick
    );
    
  
    // Init  
    logic [31:0] count, ncount, milliseconds;   
    
    // If reset, set count to 0
    always_ff @(posedge(clk), posedge(rst))
      if (rst)
       begin
        count<=0;
        milliseconds <= ((rand_ms * 100_000) - 1);
       end
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
    
    assign tick=(count==(milliseconds-1));    
    
endmodule
