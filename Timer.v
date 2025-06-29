`timescale 1ns / 1ps

module Timer(
    input [3:0] value,
    input oneHz_Enable,
    input start_timer,
    input clk,
    input Reset_Sync,
    output reg expired
);

    reg [3:0] time_left;
    reg change = 1;

    always @(posedge clk) begin
        if (Reset_Sync || start_timer) begin
            change <= 0;
            expired <= 0;
        end
        else if (!change) begin
            time_left <= value - 1;
            change <= 1;
            expired <= 0;
        end
        else if (oneHz_Enable) begin
            if (time_left == 0) begin
                expired <= 1;
            end else begin
                time_left <= time_left - 1;
                expired <= 0;
            end
        end
        else begin
            expired <= 0;
        end
    end

endmodule
