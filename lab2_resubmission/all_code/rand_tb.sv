`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2025 03:44:11 PM
// Design Name: 
// Module Name: rand_tb
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


module rand_tb;

    // Counter
    logic clk;
    logic rnd;   
    logic rst;
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end       
    
    prbs_lfsr jw_pl1(
     .clk(clk),
     .rst(rst),
    
     .rnd(rnd)
    );    

    //
    logic [3:0] count_out;
    fourteen_counter jw_ah14(
      .clk(clk),
      .en(1),
      .rst(0),
      
      .count_out(count_out)
    );
    
    logic [13:0] rand_ms;
    rand_generator jw_generator1(
        .clk(clk),
        .rnd(rnd),
        .count(count_out),
        
        .rand_ms(rand_ms)    
    );


    // Testbench
    initial begin
      rst = 1;
      #5
      
      rst = 0;
      #5000 $finish;
     end     
    
endmodule
