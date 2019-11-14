`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:31 11/12/2019 
// Design Name: 
// Module Name:    Captura 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Captura(
    input [7:0] Data,
    input Href,
    input Vsync,
    input Pclk,
    output reg regWrite,
    output reg addr_in,
	 output reg data_in[7:0]
    );
	 wire contador=0;
always @ (negedge Pclk) begin
	if	(Vsync==1) begin
		if	(Href==1) begin
			if	(contador==0)begin
assign data_in[7:5]={Data[7:5]};
assign data_in[4:2]={Data[2:0]};
contador=1;
			end
			if	(contador==1)begin
assign data_in[1:0]={Data[4:3]};
contador=0;
			end
end
end

end

endmodule
