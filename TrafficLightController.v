`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 23:04:06
// Design Name: 
// Module Name: TrafficLightController
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
// Cleaned Top-Level Module for Traffic Light Controller with exposed `interval` and `value`
//==========================
// TrafficLightController.v
//==========================

module TrafficLightController(
    input Reset,
    input Sensor,
    input Walk_Request,
    input Reprogram,
    input [1:0] Time_Parameter_Selector,
    input [3:0] Time_Value,
    input clk,
    output [6:0] LEDs,
    output [1:0] interval,
    output [3:0] value,
    output expired,
    output start_timer
);

    wire Reset_Sync, Sensor_Sync, WR_Sync, WR, WR_Reset;
    wire Prog_Sync, oneHz_Enable;
    wire [1:0] interval_internal;
    wire [3:0] value_internal;

    assign interval = interval_internal;
    assign value = value_internal;

    Divider divider (
        .Reset_Sync(Reset_Sync),
        .clk(clk),
        .oneHz_Enable(oneHz_Enable)
    );

    FSM fsm (
        .Sensor_Sync(Sensor_Sync),
        .WR(WR),
        .WR_Reset(WR_Reset),
        .LEDs(LEDs),
        .interval(interval_internal),
        .start_timer(start_timer),
        .expired(expired),
        .Prog_Sync(Prog_Sync),
        .clk(clk),
        .Reset_Sync(Reset_Sync)
    );

    synchronizer synchronizer (
        .Reset(Reset),
        .Sensor(Sensor),
        .Walk_Request(Walk_Request),
        .Reprogram(Reprogram),
        .clk(clk),
        .Prog_Sync(Prog_Sync),
        .WR_Sync(WR_Sync),
        .Sensor_Sync(Sensor_Sync),
        .Reset_Sync(Reset_Sync)
    );

    Time_Parameters timeParameter (
        .selector(Time_Parameter_Selector),
        .Time_value(Time_Value),
        .Prog_Sync(Prog_Sync),
        .interval(interval_internal),
        .clk(clk),
        .value(value_internal)
    );

    Timer timer (
        .value(value_internal),
        .oneHz_Enable(oneHz_Enable),
        .start_timer(start_timer),
        .clk(clk),
        .expired(expired),
        .Reset_Sync(Reset_Sync)
    );

    WR walkRegister (
        .clk(clk),
        .Reset_Sync(Reset_Sync),
        .WR_Sync(WR_Sync),
        .WR_Reset(WR_Reset),
        .WR(WR)
    );

endmodule

