`timescale 1ns / 1ps


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


