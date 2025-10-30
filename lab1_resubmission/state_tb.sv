`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 09:35:32 PM
// Design Name: 
// Module Name: state_tb
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

    // Init
    logic en;
    logic cw;
    logic clk;
    logic [2:0] state;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end    
    
    initial begin
        state=0;
    end
    
    // Instantiate
    state dut(
        .en(en),
        .cw(cw),
        .clk(clk),
        .state(state)
    );
    
    // Test stimulus
    initial begin
      state=0;
      cw = 0; 
      en = 0;
        
      // Cycle 1 - Run CCW
      #10 @(posedge clk);
      en = 1;

      // Cycle 2 - Pause
      #200 @(posedge clk);
      en = 0;
      cw = 1;

      // Cycle 3 - Run CW
      #100 @(posedge clk);
      en=1;

      // Finish simulation
      #200 $finish;
    end  

endmodule
