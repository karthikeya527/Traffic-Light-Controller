module TrafficLightController_tb;

  // Inputs
  reg clk = 0;
  reg Reset;
  reg Sensor;
  reg Walk_Request;
  reg Reprogram;
  reg [1:0] Time_Parameter_Selector;
  reg [3:0] Time_Value;

  // Outputs
  wire [6:0] LEDs;
  wire [3:0] value;
  wire [1:0] interval;

  // Internal signals for debugging
  wire expired;
  wire start_timer;

  // Clock generation (50 MHz → 20 ns period)
  always #10 clk = ~clk;

  // Instantiate DUT
  TrafficLightController dut (
    .Reset(Reset),
    .Sensor(Sensor),
    .Walk_Request(Walk_Request),
    .Reprogram(Reprogram),
    .Time_Parameter_Selector(Time_Parameter_Selector),
    .Time_Value(Time_Value),
    .clk(clk),
    .LEDs(LEDs)
  );

  // Dump waveform
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, TrafficLightController_tb);
  end

  // Simulation stimulus
  initial begin
    $display("Time resolution is 1 ps");

    $monitor("T=%0t | LEDs=%b | interval=%b | value=%2d | expired=%b | start_timer=%b",
             $time, LEDs, dut.interval, dut.value, dut.timer.expired, dut.fsm.start_timer);

    // Initialize inputs
    clk = 0;
    Reset = 1;
    Sensor = 0;
    Walk_Request = 0;
    Reprogram = 0;
    Time_Parameter_Selector = 0;
    Time_Value = 4'd6;

    // Reset active
    #100;
    Reset = 0;

    // Reprogram `ty` to 4
    #100;
    Time_Parameter_Selector = 2'b11;
    Time_Value = 4;
    Reprogram = 1;
    #20;
    Reprogram = 0;

    // Wait, then reprogram `tb` to 8
    #300000;
    Time_Parameter_Selector = 2'b01;
    Time_Value = 8;
    Reprogram = 1;
    #20;
    Reprogram = 0;

    // Allow FSM to cycle using new tb value
    #1500000;
    $finish;
  end

endmodule
