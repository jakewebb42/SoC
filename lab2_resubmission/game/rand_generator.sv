`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 04:59:39 PM
// Design Name: 
// Module Name: rand_generator
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


module rand_generator(
    input logic clk,
    input rnd,
    input [3:0] count,
    
    output logic [31:0] rand_ms
    );
    
    logic [13:0] rand_ms_temp;
    assign rand_ms[31:14] = 0;
    
    always_ff @(posedge clk) begin
      rand_ms_temp[count] = rnd;
    end
    
    always_comb begin
      if (rand_ms_temp < 2000)
        rand_ms[13:0] = 2000;
      else if (rand_ms_temp > 15000)
        rand_ms[13:0] = 15000;
      else
        rand_ms[13:0] = rand_ms_temp;
    end
    
endmodule
