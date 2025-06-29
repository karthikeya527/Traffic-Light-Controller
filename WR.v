`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 22:50:53
// Design Name: 
// Module Name: WR
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



 module WR(
    input clk,
    input Reset_Sync,
    input WR_Sync,
    input WR_Reset,
    output reg WR
);
    always @(posedge clk) begin
        if (Reset_Sync) WR <= 0;
        else if (WR_Sync) WR <= 1;
        else if (WR_Reset) WR <= 0;
    end
endmodule


