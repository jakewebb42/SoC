`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 01:24:22 PM
// Design Name: 
// Module Name: digit_handler
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


module digit_handler(
    input logic [1:0] anode_index,
    input logic [3:0] digit_array[3:0],
    
    output logic [3:0] digit
    );
    
    assign digit = digit_array[anode_index];
    
endmodule
