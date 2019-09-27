`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/28 15:29:36
// Design Name: 
// Module Name: fifo_test1
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
module fifo_test1 (); /* this is automatically generated */
	
	//inputs
	reg clk;
	reg rst;
	reg [7 : 0] din;
	reg wr_en;
	reg rd_en;

	//outputs
	wire [7 : 0] dout;
	wire full;
	wire almost_empty;
	wire almost_full;
	wire empty;
	wire [3 : 0] data_count;
	wire prog_full;
	wire prog_empty;

	// Instantiate the Unit Under Test(UUT)
	// verilator lint_off WIDTH
	fifo_test fifo_te(
		.clk          (clk),
		.rst          (rst),
		.din          (din),
		.wr_en        (wr_en),
		.rd_en        (rd_en),
		.dout         (dout),
		.full         (full),
		.almost_full  (almost_full),
		.empty        (empty),
		.almost_empty (almost_empty),
		.data_count   (data_count),
		.prog_full    (prog_full),
		.prog_empty   (prog_empty)
		);
	// verilator lint_on WIDTH
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		din = 0;
		wr_en = 0;
		rd_en = 0;
	// verilator lint_off STMTDLY 
		// wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		rst = 0;
			#200;

		repeat (16) begin
				wr_en = 1;
				#20;
				wr_en = 0;
				#20;
				din = din + 1'b1;
		end
			#100
			repeat (16) begin
					rd_en = 1;
					#20;
					rd_en = 0;
					#20;
		end
	end
	always  begin
		clk = ~clk;
		#10;
	end
	// verilator lint_on STMTDLY 
endmodule

