`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 07:11:06 PM
// Design Name: 
// Module Name: led_blink
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


module led_blink(
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    output logic [31:0] rd_data,
    input  logic [31:0] wr_data,
    // external port    
    output logic [3:0] dout
    );

    // Write Buffer Logic
    logic [15:0] wr_buffer [3:0];
    
    always_ff @(posedge(clk), posedge(reset)) begin
      if (reset) begin
        wr_buffer[3] = 0;
        wr_buffer[2] = 0;
        wr_buffer[1] = 0;
        wr_buffer[0] = 0;
      end
      else begin
        case(addr)
          0: wr_buffer[0] <= wr_data[15:0];
          1: wr_buffer[1] <= wr_data[15:0];
          2: wr_buffer[2] <= wr_data[15:0];
          3: wr_buffer[3] <= wr_data[15:0];
          default: wr_buffer[3:0] <= wr_buffer[3:0];
        endcase
      end
    end
    
    // Write Data Logic
    logic [63:0] wr_data_cycles [3:0];
    assign wr_data_cycles[3] = wr_buffer[3] * 100_000;   
    assign wr_data_cycles[2] = wr_buffer[2] * 100_000;   
    assign wr_data_cycles[1] = wr_buffer[1] * 100_000;   
    assign wr_data_cycles[0] = wr_buffer[0] * 100_000;       
    
    // Init Vars
    logic [63:0] timer [3:0];
    logic [3:0] buf_reg;
       
    // Timer 3
    always_ff @(posedge(clk), posedge(reset)) begin
      if (reset)
        timer[3] <= 0;
      else begin
        if (timer[3] < wr_data_cycles[3])
          timer[3] <= timer[3] + 1;
        else
          timer[3] <= 0;
      end
    end

   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)
         buf_reg[3] <= 0;
      else begin
         if (timer[3] == 64'h0000000000000001)
          begin
            case(buf_reg[3])
             0: buf_reg[3] <= 1;
             1: buf_reg[3] <= 0;
             default: buf_reg[3] <= 1;
            endcase
          end
      end

    // Timer 2
    always_ff @(posedge(clk), posedge(reset)) begin
      if (reset)
        timer[2] <= 0;
      else begin
        if (timer[2] < wr_data_cycles[2])
          timer[2] <= timer[2] + 1;
        else
          timer[2] <= 0;
      end
    end

   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)
         buf_reg[2] <= 0;
      else begin
         if (timer[2] == 64'h0000000000000001)
          begin
            case(buf_reg[2])
             0: buf_reg[2] <= 1;
             1: buf_reg[2] <= 0;
             default: buf_reg[2] <= 1;
            endcase
          end
      end

    // Timer 1
    always_ff @(posedge(clk), posedge(reset)) begin
      if (reset)
        timer[1] <= 0;
      else begin
        if (timer[1] < wr_data_cycles[1])
          timer[1] <= timer[1] + 1;
        else
          timer[1] <= 0;
      end
    end

   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)
         buf_reg[1] <= 0;
      else begin
         if (timer[1] == 64'h0000000000000001)
          begin
            case(buf_reg[1])
             0: buf_reg[1] <= 1;
             1: buf_reg[1] <= 0;
             default: buf_reg[1] <= 1;
            endcase
         end
      end
      
    // Timer 0
    always_ff @(posedge(clk), posedge(reset)) begin
      if (reset)
        timer[0] <= 0;
      else begin
        if (timer[0] < wr_data_cycles[0])
          timer[0] <= timer[0] + 1;
        else
          timer[0] <= 0;
      end
    end

   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)
         buf_reg[0] <= 0;
      else begin
         if (timer[0] == 64'h0000000000000001)
          begin
            case(buf_reg[0])
             0: buf_reg[0] <= 1;
             1: buf_reg[0] <= 0;
             default: buf_reg[0] <= 1;
            endcase
          end
      end       
            
   // decoding logic 
   assign wr_en = cs && write;
   // slot read interface
   assign rd_data =  0; // not reading so always 0
   // external output  
   assign dout[3:0] = buf_reg[3:0];   
    
endmodule
