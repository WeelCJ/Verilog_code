`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/23 11:45:01
// Design Name: 
// Module Name: ram_test1
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


module ram_test1();

reg clka;
reg ena;
reg wea;
reg [3 : 0] addra;
reg [15 : 0] dina;
wire [15 : 0] douta;

ram1 ram_te (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [3 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .douta(douta)  // output wire [15 : 0] douta
);

always  #10 clka <= ~clka;
	
initial begin
	clka = 0;
	ena = 1;
	wea = 0;
	addra = 0;
	dina = 0;
	
	#100;
	wea = 1;
	addra = 1;
	dina = 16'hbbbb;
	#20;
	wea = 0;
	
	#20;
	addra = 0;
	#20;
	wea = 0;
	
	#100;
	addra = 1;
end

endmodule
