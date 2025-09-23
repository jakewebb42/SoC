`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2025 05:55:54 PM
// Design Name: 
// Module Name: sseg_controller_tb
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

module state_tb;

    logic clk;
    logic rnd;
    logic BTNL, BTNC, BTNR;

    logic is_led_on;
    logic [15:0] hex_full;
    logic [2:0] state_out;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end    

    // Controller
    state dut(
      .clk(clk),
      .BTNL(BTNL), .BTNC(BTNC), .BTNR(BTNR),
      
      .is_led_on(is_led_on),
      .hex_full(hex_full),
      .state_out(state_out)
    );
    
    initial begin
      #5  
      
      // INIT to WAIT
      @(posedge clk)
      BTNL=1;
      #1
      BTNL=0;
      #50
      
      // WAIT to GAME
      @(posedge clk)
      rnd=1'b1;
      #1
      rnd=1'b0;
      #50
      
      // GAME to ON_TIME
      @(posedge clk)
      BTNC=1;
      #1
      BTNC=0;
      #50      
      
      // ON_TIME to INIT
      @(posedge clk)
      BTNR=1;
      #1
      BTNR=0;
      #50 
            
      $finish;
    end

endmodule
