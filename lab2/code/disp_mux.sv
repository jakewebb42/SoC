`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2025 03:15:30 PM
// Design Name: 
// Module Name: disp_mux
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


module disp_mux(
    input logic clk, reset,
    input logic [7:0] in3, in2, in1, in0,
    output logic AN,
    output logic [7:0] sseg // led
    );
    
    localparam N=18;
    
    logic [N-1:0] q_reg;
    logic [N-1:0] q_next;
    
    // N-bit counter
    // regiset
    always_ff @(posedge clk, posedge reset)
      if (reset)
        q_reg <= 0;
      else
        q_reg <= q_next;
        
    assign q_next = q_reg + 1;
    
    // 2 MSBs of counter to control
    always_comb
      case (q_reg[N-1:N-2])
        2'b00:
          begin
            AN   
    
    
    
endmodule
