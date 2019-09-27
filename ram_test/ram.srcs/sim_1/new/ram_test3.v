`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/23 21:58:17
// Design Name: 
// Module Name: ram_test3
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


module ram_test3;
reg clka,clkb,ena,enb,wea,web;
reg [9:0] addra,addrb;
reg [15:0] dia,dib;
wire [15:0] doa,dob;
    always #10 clka <= ~clka;
	always #10 clkb <= ~clkb;

    initial begin
        clka = 0;
		clkb = 0;
		ena = 1;
		enb = 0;
		wea = 0;
		web = 0;
		addra = 0;
		addrb = 0;
		dia = 0;
		dib = 0;
		
		#100;
		wea = 1;
		addra = 1;
		dia = 16'hbbbb;
		
		#20;
		wea = 0;
		
		#20;
		enb = 1;
		
		#100;
		addrb = 1;
		
		#20;
		//enb = 0;
    end
    
ram3 ram_tes(
	.clka(clka),
	.clkb(clkb),
	.ena(ena),
	.enb(enb),
	.wea(wea),
	.web(web),
	.addra(addra),
	.addrb(addrb),
	.dia(dia),
	.dib(dib),
	.doa(doa),
	.dob(dob)
    );

endmodule