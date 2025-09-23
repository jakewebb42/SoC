`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2025 02:51:52 PM
// Design Name: 
// Module Name: sseg_controller
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


module sseg_controller(
    input logic clk,
    input logic en,
    input logic [15:0] hex_in,
    
    output logic [2:0] anode_index,
    output logic [3:0] hex_out
    );
  
   // Cycle through anodes
   logic [2:0] idx, next_idx;
  
   always_ff @(posedge(clk)) begin
   
     case(idx)
       3'b000: next_idx<=3'b011;
       3'b001: next_idx<=3'b000;
       3'b010: next_idx<=3'b001;
       3'b011: next_idx<=3'b010;
       default: next_idx<=3'b000;
     endcase
     
     case(idx)
       3'b000: hex_out[3:0]<=hex_in[3:0];
       3'b001: hex_out[3:0]<=hex_in[7:4];
       3'b010: hex_out[3:0]<=hex_in[11:8];
       3'b011: hex_out[3:0]<=hex_in[15:12];
       default: hex_out[3:0]<=4'b0000;
     endcase

      // Move if enabled, else stay
      if (en) 
        begin
          idx<=next_idx;
        end
      else 
        begin
          idx<=idx;
        end      
   end
  
   assign anode_index = idx;
    
endmodule
