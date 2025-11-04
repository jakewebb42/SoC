`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2025 09:28:10 AM
// Design Name: 
// Module Name: game_tb
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


module game_tb;

    logic CLK100MHZ;
    
    initial begin
        CLK100MHZ = 0;
        forever #5 CLK100MHZ = ~CLK100MHZ;
    end    
        
    logic btn_start;
    logic btn_stop;
    logic btn_clear;
        
    logic LED;
    logic [31:0] number;
    
    // PRBS LFSR
    logic rnd;
    logic prbs_rst;
    assign prbs_rst = ~rand_rst;
    
    prbs_lfsr jw_pl(
      .clk(CLK100MHZ),
      .rst(prbs_rst),
      
      .rnd(rnd)
    );
    
    // Count to 14
    logic [3:0] fourteen_count;
    fourteen_counter jw_14(
      .clk(CLK100MHZ),
      .en(1),
      .rst(0),
      
      .count_out(fourteen_count)
    );
    
    // Rand Generator
    logic [31:0] rand_ms;
    rand_generator jw_rg(
        .clk(CLK100MHZ),
        .rnd(rnd),
        .count(fourteen_count),
        
        .rand_ms(rand_ms) // e.g. 1000 ms
    );
    
    // Rand Counter
    logic rand_tick;
    
    rand_counter jw_rc(
        .clk(CLK100MHZ),
        .rand_ms(rand_ms),
        .en(rand_en),
        .rst(rand_rst),
        
        .tick(rand_tick) // ticks when rand_ms is counted up to
    );
    
    // ms Tick
    logic ms_tick;
    
    ms_tick jw_mst(
        .clk(CLK100MHZ),
        
        .tick(ms_tick)
    );
    
    // ms Counter
    logic [31:0] ms_passed;
    ms_counter jw_msc(
        .clk(CLK100MHZ),
        .tick_in(ms_tick),
        .en(ms_en),
        .rst(ms_rst),
        
        .ms_passed(ms_passed)
    );
    
    // State Changer
    logic [2:0] state;
    logic ms_en, ms_rst;
    logic rand_en, rand_rst, rand_gen_rst;
    
    state jw_s(
        // Inputs
        .clk(CLK100MHZ),
        .ms_passed(ms_passed),
        .rand_tick(rand_tick),
        
        .btn_start(btn_start),
        .btn_stop(btn_stop),
        .btn_clear(btn_clear),
        
        // Outputs
        .state_out(state),
        
        .ms_en(ms_en),
        .ms_rst(ms_rst),
        
        .rand_en(rand_en),
        .rand_rst(rand_rst)
    );
    
    // State Handler
    state_handler jw_sh(
        .state(state),
        .ms_passed(ms_passed),
        
        .LED(LED),
        .number(number)
    );
    
    // Testbench
        // Testbench
    // TB
    initial begin
      #5
      prbs_rst = 1;
      
      #5
      prbs_rst = 0;
      
      #500
      btn_start = 1;
      
      #10
      btn_start = 0;
      
      
      #500
      
    
      #500 $finish;
     end     
    
    

endmodule
