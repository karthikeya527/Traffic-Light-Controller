`timescale 1ns / 1ps



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


