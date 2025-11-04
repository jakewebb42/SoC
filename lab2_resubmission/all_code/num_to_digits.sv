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
    
    always_comb begin
      if (number == -1) // Init State
        begin
          digit_array[3] = 4'hb; // 4'bzzzz is blank
          digit_array[2] = 4'hb; 
          digit_array[1] = 4'ha; // 4'bxxxx is H
          digit_array[0] = 1;
        end
      else if (number == -2) // Wait State
        begin
          digit_array[3] = 4'hb;
          digit_array[2] = 4'hb;
          digit_array[1] = 4'hb;
          digit_array[0] = 4'hb;
        end      
      else
        begin
          digit_array[3] = number / 1000;
          digit_array[2] = (number % 1000) / 100;            
          digit_array[1] = ((number % 1000) % 100) / 10;            
          digit_array[0] = (((number % 1000) % 100) % 10);         
        end
    end
 
    
endmodule
