`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 03:45:03 PM
// Design Name: 
// Module Name: state_handler
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


module state_handler(
    input logic [2:0] state,
    input logic [31:0] ms_passed,
    
    output logic LED,
    output logic [31:0] number
    );
    
    // Params------------------------------------------------------------------
    
    // State Params
    parameter INIT_STATE    = 3'b000;
    parameter WAIT_STATE    = 3'b001;
    parameter GAME_STATE    = 3'b010;
    
    parameter ON_TIME_STATE = 3'b011;
    parameter LATE_STATE    = 3'b100;
    parameter EARLY_STATE   = 3'b101;
    
    // LED Params
    parameter LED_ON  = 1;
    parameter LED_OFF = 0;
    
    // Output Control----------------------------------------------------------
    always_comb begin
      // LED Control
      if (state == GAME_STATE)
        LED = LED_ON;
      else
        LED = LED_OFF;      
      
      // Number Control
      case(state)
        INIT_STATE: number = -1;
        WAIT_STATE: number = -2;
        GAME_STATE: number = ms_passed;
    
        ON_TIME_STATE: number = ms_passed;
        LATE_STATE:    number = 1000;
        EARLY_STATE:   number = 9999;
      endcase
      
    end // always_comb   
        
endmodule
