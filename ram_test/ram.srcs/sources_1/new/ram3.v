`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/23 21:57:32
// Design Name: 
// Module Name: ram3
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

//True Dual port Ram

module ram3(clka,clkb,ena,enb,wea,web,addra,addrb,dia,dib,doa,dob);
input clka,clkb,ena,enb,wea,web;
input [9:0] addra,addrb;
input [15:0] dia,dib;
output [15:0] doa,dob;
reg[15:0] ram [1023:0];
reg[15:0] doa,dob;
always @(posedge clka) 
begin
	if (ena)
	begin
		if (wea)
			ram[addra] <= dia;
			doa <= ram[addra];
	end
end
always @(posedge clkb) 
begin
	if (enb)
	begin
		if (web)
			ram[addrb] <= dib;
			dob <= ram[addrb];
	end
end
endmodule