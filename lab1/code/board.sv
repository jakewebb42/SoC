`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2025 07:21:44 PM
// Design Name: 
// Module Name: output
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
    input logic [15:0] SW,
    input logic clk,
    input logic [2:0] state,
    
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic CA,CB,CC,CD,CE,CF,CG
    );    
    
    // Parameters
    parameter SEG_ON = 0;
    parameter SEG_OFF = 1;
    parameter AN_ON = 0;
    parameter AN_OFF = 1;
    
    // See State
    assign LED[15:3] = 0;
    assign LED[2:0] = state[2:0];  
    
    // Go Through States
    always_comb @(posedge clk) begin
      case (state)
        3'b000: 
         begin
           AN[3]=AN_ON; AN[2]=AN_OFF; AN[1]=AN_OFF; AN[0]=AN_OFF;
           CA=SEG_ON; CB=SEG_ON; CC=SEG_OFF; CD=SEG_OFF; CE=SEG_OFF; CF=SEG_ON; CG=SEG_ON;
         end
        3'b001:
         begin
           AN[3]=AN_OFF; AN[2]=AN_ON; AN[1]=AN_OFF; AN[0]=AN_OFF;
           CA=SEG_ON; CB=SEG_ON; CC=SEG_OFF; CD=SEG_OFF; CE=SEG_OFF; CF=SEG_ON; CG=SEG_ON;         
         end
        3'b010:
         begin
           AN[3]=AN_OFF; AN[2]=AN_OFF; AN[1]=AN_ON; AN[0]=AN_OFF;
           CA=SEG_ON; CB=SEG_ON; CC=SEG_OFF; CD=SEG_OFF; CE=SEG_OFF; CF=SEG_ON; CG=SEG_ON;         
         end
        3'b011:
         begin
           AN[3]=AN_OFF; AN[2]=AN_OFF; AN[1]=AN_OFF; AN[0]=AN_ON;
           CA=SEG_ON; CB=SEG_ON; CC=SEG_OFF; CD=SEG_OFF; CE=SEG_OFF; CF=SEG_ON; CG=SEG_ON;        
         end
        3'b100: 
         begin
           AN[3]=AN_OFF; AN[2]=AN_OFF; AN[1]=AN_OFF; AN[0]=AN_ON;
           CA=SEG_OFF; CB=SEG_OFF; CC=SEG_ON; CD=SEG_ON; CE=SEG_ON; CF=SEG_OFF; CG=SEG_ON;  
         end
        3'b101:
         begin
           AN[3]=AN_OFF; AN[2]=AN_OFF; AN[1]=AN_ON; AN[0]=AN_OFF;
           CA=SEG_OFF; CB=SEG_OFF; CC=SEG_ON; CD=SEG_ON; CE=SEG_ON; CF=SEG_OFF; CG=SEG_ON;         
         end
        3'b110:
         begin
           AN[3]=AN_OFF; AN[2]=AN_ON; AN[1]=AN_OFF; AN[0]=AN_OFF;
           CA=SEG_OFF; CB=SEG_OFF; CC=SEG_ON; CD=SEG_ON; CE=SEG_ON; CF=SEG_OFF; CG=SEG_ON;          
         end
        3'b111:
         begin
           AN[3]=AN_ON; AN[2]=AN_OFF; AN[1]=AN_OFF; AN[0]=AN_OFF;
           CA=SEG_OFF; CB=SEG_OFF; CC=SEG_ON; CD=SEG_ON; CE=SEG_ON; CF=SEG_OFF; CG=SEG_ON;        
         end
        default:
         begin
           AN[3:0]=AN_OFF;  
           CA=SEG_OFF; CB=SEG_OFF; CC=SEG_OFF; CD=SEG_OFF; CE=SEG_OFF; CF=SEG_OFF; CG=SEG_OFF;          
         end
      endcase
    end    
    
endmodule
