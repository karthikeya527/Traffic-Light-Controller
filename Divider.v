`timescale 1ns / 1ps



module Divider(
    input clk,
    input Reset_Sync,
    output reg oneHz_Enable
);

    localparam [26:0] hz_constant = 27'd1000;  // For simulation only
    reg [26:0] counter = hz_constant;

    always @(posedge clk) begin
        if (Reset_Sync) begin
            counter <= hz_constant;
            oneHz_Enable <= 0;
        end else begin
            if (counter == 0) begin
                oneHz_Enable <= 1;
                counter <= hz_constant;
            end else begin
                counter <= counter - 1;
                oneHz_Enable <= 0;
            end
        end
    end

endmodule


