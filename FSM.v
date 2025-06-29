`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 21:13:25
// Design Name: 
// Module Name: FSM
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

module FSM(
    input Sensor_Sync,
    input WR,
    output reg WR_Reset,
    output reg [6:0] LEDs,
    output reg [1:0] interval,
    output reg start_timer,
    input expired,
    input Prog_Sync,
    input Reset_Sync,
    input clk
);
    localparam tb = 2'b00, te = 2'b01, ty = 2'b10;
    localparam A = 7'b0011000, B = 7'b0101000, C = 7'b1000010,
               D = 7'b1000100, E = 7'b1001001;

    reg deviate, senseOneTime;
    reg start_timer_flag;

    // latch flag into start_timer
    always @(posedge clk) begin
        start_timer <= start_timer_flag;
        start_timer_flag <= 0;
    end

    always @(posedge clk) begin
        if (Prog_Sync || Reset_Sync) begin
            LEDs <= A;
            interval <= tb;
            WR_Reset <= 0;
            start_timer_flag <= 1;
            deviate <= 1;
            senseOneTime <= 1;
        end
        else if (expired) begin
            case (LEDs)
                A: if (deviate) begin
                        if (Sensor_Sync & senseOneTime) begin
                            LEDs <= A;
                            interval <= te;
                            start_timer_flag <= 1;
                            senseOneTime <= 0;
                        end else begin
                            LEDs <= A;
                            interval <= tb;
                            start_timer_flag <= 1;
                        end
                        deviate <= 0;
                    end else begin
                        LEDs <= B;
                        interval <= ty;
                        start_timer_flag <= 1;
                    end

                B: begin
                        if (WR) begin
                            LEDs <= E;
                            interval <= te;
                            start_timer_flag <= 1;
                            WR_Reset <= 1;
                        end else begin
                            LEDs <= C;
                            interval <= tb;
                            start_timer_flag <= 1;
                        end
                        senseOneTime <= 1;
                    end

                C: if (Sensor_Sync & senseOneTime) begin
                        LEDs <= C;
                        interval <= te;
                        start_timer_flag <= 1;
                        senseOneTime <= 0;
                    end else begin
                        LEDs <= D;
                        interval <= ty;
                        start_timer_flag <= 1;
                        senseOneTime <= 1;
                    end

                D: begin
                        LEDs <= A;
                        interval <= tb;
                        start_timer_flag <= 1;
                        deviate <= 1;
                        senseOneTime <= 1;
                    end

                E: begin
                        LEDs <= C;
                        interval <= tb;
                        start_timer_flag <= 1;
                        WR_Reset <= 0;
                        senseOneTime <= 1;
                    end
            endcase
        end
    end

endmodule

