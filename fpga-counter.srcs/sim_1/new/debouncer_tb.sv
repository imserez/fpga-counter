`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 13:43:17
// Design Name: 
// Module Name: debouncer_tb
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


module debouncer_tb;

logic   clk;
logic   unbounced_signal;
logic   debounced_signal_output;
logic   reset;

debouncer #(.N(4), .LIMIT(5)) dut (
    .clk(clk),
    .signal(unbounced_signal),
    .debounced_signal(debounced_signal_output),
    .reset(reset)
);

initial     clk = 0;
initial     debounced_signal_output = 0;
initial     unbounced_signal = 0;
always #5 clk = ~clk;

initial begin
    reset = 1;
    #10
    reset = 0;
    unbounced_signal = 1;
    #10
    unbounced_signal = 0;
    #20
    unbounced_signal = 1;
    #200
    unbounced_signal = 0;
    #10
    unbounced_signal = 1;
    #20
    unbounced_signal = 0;
    #200
    $finish;
end

endmodule
