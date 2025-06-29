`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 14:22:42
// Design Name: 
// Module Name: synchronizer
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

module synchronizer(
    input Reset,
    input Sensor,
    input Walk_Request,
    input Reprogram,
    input clk,
    output reg Prog_Sync,
    output reg WR_Sync,
    output reg Sensor_Sync,
    output reg Reset_Sync
);

    always @(posedge clk) begin
        Reset_Sync   <= Reset;
        Sensor_Sync  <= Sensor;
        WR_Sync      <= Walk_Request;
        Prog_Sync    <= Reprogram;
    end

endmodule


