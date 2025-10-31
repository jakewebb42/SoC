`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 02:05:49 PM
// Design Name: 
// Module Name: board
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


module board(
    input logic CLK100MHZ,
    input logic [31:0] number,

    output logic [7:0] AN,
    output logic CA, CB, CC, CD, CE, CF, CG
    );
    
    
    // Counter
    logic tick;   
    
    output_counter jw_oc(
     .clk(CLK100MHZ),
     .rst(0),
     .en(1),
    
     .tick(tick)
    );    

    // Anode Handler    
    logic [1:0] anode_index;   
    
    anode_handler jw_ah(
      .clk(CLK100MHZ),
      .en(tick),
      
      .anode_index(anode_index)
    );
    
    // Num to Digits
    logic [3:0] digit_array[3:0];
    
    num_to_digits jw_ntd2(
      .number(number),
      
      .digit_array(digit_array)
    );
    
    // Digit Handler
    logic [3:0] digit;
    
    digit_handler jw_dw(
      .anode_index(anode_index),
      .digit_array(digit_array),
      
      .digit(digit)
    );
    
    // Hex to SSEG
    logic [6:0] sseg;
    hex_to_sseg jw_hts(
      .hex(digit),
      
      .sseg(sseg)
    );
    
    // Output Handler
    output_handler jw_oh(
      .anode_index(anode_index),
      .sseg(sseg),
      
      .AN(AN[3:0]),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );   
        
    assign AN[7:4] = 4'b1111; // only use right side of board
endmodule
