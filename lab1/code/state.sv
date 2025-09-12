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
    input logic en,
    input logic cw,
    input logic clk,
    output logic [2:0] state
    );
      
    // Init
    logic [2:0] next_state;
    
    // State Machine
    always_ff @(posedge clk) begin
    
      // If CW, go clockwise, else go counter-clockwise
      if (cw==1) 
        begin
          case (state)
            3'b000: next_state<=3'b001;
            3'b001: next_state<=3'b010;
            3'b010: next_state<=3'b011;
            3'b011: next_state<=3'b100;
            3'b100: next_state<=3'b101;
            3'b101: next_state<=3'b110;
            3'b110: next_state<=3'b111;
            3'b111: next_state<=3'b000;
        
            default: next_state<=0; // default to top left
          endcase
        end //cw
      else if (cw==0) 
        begin 
          case (state)
            3'b000: next_state<=3'b111;
            3'b001: next_state<=3'b000;
            3'b010: next_state<=3'b001;
            3'b011: next_state<=3'b010;
            3'b100: next_state<=3'b011;
            3'b101: next_state<=3'b100;
            3'b110: next_state<=3'b101;
            3'b111: next_state<=3'b110;
        
            default: next_state<=0; // default to top left
          endcase        
        end //ccw

      // Move if enabled, else stay
      if (en==1) 
        begin
          state<=next_state;
        end
      else if (en==0) 
        begin
          state<=state;
        end
    end // @posedge
    
endmodule
