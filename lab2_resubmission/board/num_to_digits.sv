`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 01:10:46 PM
// Design Name: 
// Module Name: num_to_digits
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


module num_to_digits(
    input logic [31:0] number,
    
    output logic [3:0] digit_array[3:0]
    );
    
    assign digit_array[3] = number / 1000;
    assign digit_array[2]  = (number % 1000) / 100;
    assign digit_array[1]   = ((number % 1000) % 100) / 10;
    assign digit_array[0]   = (((number % 1000) % 100) % 10);    
    
endmodule
