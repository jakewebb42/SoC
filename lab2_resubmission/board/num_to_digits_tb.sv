`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 01:15:21 PM
// Design Name: 
// Module Name: num_to_digits_tb
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


module num_to_digits_tb;

    // Input
    logic [31:0] number;
    
    // Output
    logic [3:0] digits[3:0];

    // Instantiation
    num_to_digits jw_ntd(
      .number(number),
      
      .digit_array(digits)
    );
    
    // Testbench
    initial begin
      number = 1237;
      #5
      
      number = 6849;
      #5
      
      number = 9238;
      #500 $finish;
     end  
endmodule
