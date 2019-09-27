`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/26 00:06:39
// Design Name: 
// Module Name: ram4_test
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


module ram_test4;

reg clk;

always #10 clk <= ~clk;

initial begin
	clk = 0;
end

ram4 ram4_tes(
	.clk(clk)
);

endmodule
