`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2025 01:07:25 PM
// Design Name: 
// Module Name: anode_handler
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


module anode_handler(
    input logic clk,
    input logic en,
    
    output logic [1:0] anode_index
    );
    
    logic [1:0] next_state, state;
    
    // State Machine
    always_comb begin
//      case(state)
//        2'bxx: next_state=0;
//        2'bzz: next_state=0;
//        default:next_state = state - 1;
//       endcase
      next_state = state-1;
    end // always_comb    
    
    always_ff @(posedge clk) begin
      if (en)
        state = next_state;
    end // always_ff
    
    assign anode_index = next_state;
    
endmodule
