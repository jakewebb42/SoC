`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2025 11:36:30 AM
// Design Name: 
// Module Name: board
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


module board(
    input logic clk,
    input logic is_led_on,
    input logic [6:0] sseg,
    input logic [2:0] anode_index,
    
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic CA, CB, CC, CD, CE, CF, CG
    );
    
    // Parameters
    parameter AN_ON   = 1'b0;
    parameter AN_OFF  = 1'b1;
    
    parameter LED_OFF = 0;
    parameter LED_ON  = 1;
    
    // LED
    assign LED[15:1] = LED_OFF;
    assign LED[0]    = is_led_on;
    
    // Display
    always_ff @(posedge clk) begin
      AN[7] = AN_OFF;
      AN[6] = AN_OFF;
      AN[5] = AN_OFF;
      AN[4] = AN_OFF;
      AN[3] = AN_OFF;
      AN[2] = AN_OFF;
      AN[1] = AN_OFF;
      AN[0] = AN_OFF;
      
      case (anode_index)
        3'b000: 
         begin
           AN[0]=1'b0;
         end
        3'b001:
         begin
           AN[1]=1'b0;
         end
        3'b010:
         begin
           AN[2]=1'b0;
         end
        3'b011:
         begin
          AN[3]=1'b0;
         end
        default:
         begin
           AN[3]=1'b1;  
         end
      endcase       
    
      // Set Cathodes
      CA=sseg[0];
      CB=sseg[1];
      CC=sseg[2];
      CD=sseg[3];
      CE=sseg[4];
      CF=sseg[5];
      CG=sseg[6];
    end 
      
endmodule
