`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SoC
// Engineer: Jake Webb
// 
// Create Date: 09/10/2025 09:23:30 PM
// Design Name: Ex 4.8.3
// Module Name: state
// Project Name: Lab 1
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


module state(
    input logic clk,
    input logic en,
    input logic cw,
    output logic [2:0] state
    );
      
    // Init
    logic [2:0] next_state;
    
    // State Machine
    always_comb begin
    
      // If CW, go clockwise, else go counter-clockwise
      if (cw==1) 
        begin
          next_state=state+1;
        end //cw
      else if (cw==0) 
        begin   
          next_state=state-1;  
        end //ccw
    end // always_comb
    
    // Update State on Tick from Counter (aka do it once per second)
    always_ff @(posedge clk) begin
      // Move if enabled, else stay
      if (en==1) 
        begin
          state<=next_state;
        end // en
      else if (en==0) 
        begin
          state<=state;
        end // not en
    end // always_ff
    
endmodule
