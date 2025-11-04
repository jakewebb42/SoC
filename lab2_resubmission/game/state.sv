`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 03:33:27 PM
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
    input logic [31:0] ms_passed,
    input logic rand_tick,
    
    input logic btn_start,
    input logic btn_stop,
    input logic btn_clear,
    
    output logic [2:0] state_out,
    output logic ms_en, ms_rst,
    output logic rand_en, rand_rst
    );
    
    // Init States
    logic [2:0] state, next_state;    

    parameter INIT_STATE    = 3'b000;
    parameter WAIT_STATE    = 3'b001;
    parameter GAME_STATE    = 3'b010;
    
    parameter ON_TIME_STATE = 3'b011;
    parameter LATE_STATE    = 3'b100;
    parameter EARLY_STATE   = 3'b101;
    
    // LED Params
    parameter LED_ON  = 1;
    parameter LED_OFF = 0;  

    always_ff @(posedge clk) begin
      case(state)
        INIT_STATE:
          begin
            // Init
            ms_rst <= 1;
            ms_en  <= 0;
            
            rand_rst <= 1;
            rand_en  <= 0;
          
            if (btn_start)
             state <= WAIT_STATE;
          end
          
        WAIT_STATE:
        // Once random time passes, move to GAME_STATE
          begin
            rand_rst <= 0;
            rand_en  <= 1;
            
            
            if (btn_clear)
             state <= INIT_STATE;
            else if (btn_stop)
             state <= EARLY_STATE;
            else if (rand_tick)
             state <= GAME_STATE;
          end
          
        GAME_STATE:
          begin
            rand_rst <= 1;
            rand_en  <= 0;
            
            ms_rst <= 0;
            ms_en  <= 1;
          
            if (btn_clear)
             state <= INIT_STATE;
            else if (btn_stop)
             state <= ON_TIME_STATE;
            else if (ms_passed == 999)
             state <= LATE_STATE;          
          end
          
        ON_TIME_STATE:
          begin
            ms_rst <= 0;
            ms_en  <= 0;
            
            if (btn_clear)
             state <= INIT_STATE;            
          end
          
        LATE_STATE:
          begin
            ms_rst <= 0;
            ms_en  <= 0;          
          
            if (btn_clear)
             state <= INIT_STATE;
          end
          
        EARLY_STATE:
          begin
            ms_rst <= 0;
            ms_en  <= 0;          
          
            if (btn_clear)
             state <= INIT_STATE;
          end
          
        default: state <= INIT_STATE;
      endcase
    end // always_ff  
    
    assign state_out = state;  

endmodule
