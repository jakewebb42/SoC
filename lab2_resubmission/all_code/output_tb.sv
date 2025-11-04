`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 12:51:53 PM
// Design Name: 
// Module Name: output_tb
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


module output_tb;

    // Counter
    logic clk;
    logic tick;   
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end       
    
    anode_counter jw_oc(
     .clk(clk),
     .rst(0),
     .en(1),
    
     .tick(tick)
    );    

    // Anode Handler    
    logic [1:0] anode_index;   
    
    anode_handler jw_ah(
      .clk(clk),
      .en(tick),
      
      .anode_index(anode_index)
    );
    
    // Num to Digits
    logic [3:0] digit_array[3:0];
    
    num_to_digits jw_ntd2(
      .number(10),
      
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
    logic [3:0] AN;
    logic CA, CB, CC, CD, CE, CF, CG;
    
    output_handler jw_oh(
      .anode_index(anode_index),
      .sseg(sseg),
      
      .AN(AN),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );
    
    // Testbench
    // TB
    initial begin
      #500 $finish;
     end          

endmodule
