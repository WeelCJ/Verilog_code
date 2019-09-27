`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/28 14:11:08
// Design Name: 
// Module Name: fifo_test
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


module fifo_test(
    input  clk,
    input  rst,
    input  [7 : 0] din,
    input  wr_en,
    input  rd_en,
    output [7 : 0] dout,
    output full,
    output almost_full,
    output empty,
    output almost_empty,
    output [3 : 0] data_count,
    output prog_full,
    output prog_empty
);

// verilator lint_off WIDTH
fifo_generator_0 fifo_te (
  .clk(clk),                    // input wire clk
  .rst(rst),                    // input wire rst
  .din(din),                    // input wire [7 : 0] din
  .wr_en(wr_en),                // input wire wr_en
  .rd_en(rd_en),                // input wire rd_en
  .dout(dout),                  // output wire [7 : 0] dout
  .full(full),                  // output wire full
  .almost_full(almost_full),    // output wire almost_full
  .empty(empty),                // output wire empty
  .almost_empty(almost_empty),  // output wire almost_empty
  .data_count(data_count),      // output wire [3 : 0] data_count
  .prog_full(prog_full),        // output wire prog_full
  .prog_empty(prog_empty)      // output wire prog_empty
);
// verilator lint_on WIDTH
endmodule

