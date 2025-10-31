`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 12:48:16 PM
// Design Name: 
// Module Name: output_handler
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


module output_handler(
    input logic [1:0] anode_index,
    input logic [6:0] sseg,
    
    output logic [3:0] AN, // active on low
    output logic CA, CB, CC, CD, CE, CF, CG // active on low
    );
    
    assign AN[3] = ~((anode_index[1])  & (anode_index[0]));
    assign AN[2] = ~((anode_index[1])  & (~anode_index[0]));
    assign AN[1] = ~((~anode_index[1]) & (anode_index[0]));
    assign AN[0] = ~((~anode_index[1]) & (~anode_index[0]));
    
    assign CA = sseg[0];
    assign CB = sseg[1];
    assign CC = sseg[2];
    assign CD = sseg[3];
    assign CE = sseg[4];
    assign CF = sseg[5];
    assign CG = sseg[6];
    
endmodule
