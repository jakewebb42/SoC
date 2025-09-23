`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2025 10:10:49 PM
// Design Name: 
// Module Name: state
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


module state(
    input logic clk,
    input logic rnd,
    input logic [15:0] cnt1000,
    input logic BTNL, BTNC, BTNR,

    output logic is_led_on,
    output logic [15:0] hex_full,
    output logic [2:0] state_out
    );
    
    // Parameters
    parameter INIT    = 3'b000;
    parameter WAIT    = 3'b001;
    parameter GAME    = 3'b010;
    parameter ON_TIME = 3'b011;
    parameter LATE    = 3'b100;
    parameter EARLY   = 3'b101;
    
    // States
    logic [2:0] state, nstate;
    logic [15:0] count_disp;
    
    // Logic
    always_ff @(posedge(clk)) begin
      nstate=state;
    
      // State Machine
      case(state)
       INIT: 
        begin
         if (BTNL)
          nstate=WAIT;
        end // INIT
        
       WAIT:
        begin
         if (BTNL)
          begin
           nstate=EARLY;
          end        
         else if (BTNR)
          begin
           nstate=INIT;
          end 
         else if (rnd)
          begin
           nstate=GAME;
          end
        end // WAIT 
        
       GAME:
        begin
         if (cnt1000==16'h03E8)
          begin
           nstate=LATE;
          end
         else if (BTNC)
          begin
           nstate=ON_TIME;
          end
         else if (BTNR)
          begin
           nstate=INIT;
          end
         count_disp=cnt1000;
        end // GAME
        
       ON_TIME:
        begin
         if (BTNR)
          nstate=INIT;
        end // ON_TIME
        
       LATE:
        begin
         if (BTNR)
          nstate=INIT;
        end // LATE
        
       EARLY:
        begin
         if (BTNR)
          nstate=INIT;
        end // EARLY
        
       default: nstate=INIT;
      endcase
      
      state=nstate;
      
      // Outputs
      case(state)
       INIT: 
        begin
         is_led_on<=1'b0;
         hex_full<=16'h00f1;
        end // INIT
        
       WAIT:
        begin
         is_led_on<=1'b0;
         hex_full<=16'h0000;
        end // WAIT
        
       GAME: 
        begin
         is_led_on<=1'b1;
         hex_full<=count_disp;  // Time       
        end // GAME
        
        ON_TIME:
         begin
          is_led_on<=1'b0;
          hex_full<=count_disp; // Saved time
         end // ON_TIME
         
        LATE:
         begin
          is_led_on<=1'b0;
          hex_full<=16'h03E8; // 1000
         end // LATE
         
        EARLY:
         begin
          is_led_on<=1'b0;
          hex_full<=16'h03E7; // 9999
         end // EARLY         
      endcase
    end
    
    assign state_out=state;
    
    
endmodule
