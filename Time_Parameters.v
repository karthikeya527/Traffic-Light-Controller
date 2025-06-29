`timescale 1ns / 1ps




module Time_Parameters(
    input clk,
    input Prog_Sync,
    input [1:0] interval,
    input [1:0] selector,
    input [3:0] Time_value,
    output reg [3:0] value
);

    reg [3:0] tb = 4'd6;
    reg [3:0] te = 4'd3;
    reg [3:0] ty = 4'd2;

    always @(*) begin
        case (interval)
            2'b00: value = tb;
            2'b01: value = te;
            2'b10: value = ty;
            2'b11: value = tb << 1;
            default: value = tb;
        endcase
    end

    always @(posedge clk) begin
        if (Prog_Sync) begin
            case (selector)
                2'b00: begin
                    tb <= 4'd6;
                    te <= 4'd3;
                    ty <= 4'd2;
                end
                2'b01: tb <= Time_value;
                2'b10: te <= Time_value;
                2'b11: ty <= Time_value;
            endcase
        end
    end

endmodule

