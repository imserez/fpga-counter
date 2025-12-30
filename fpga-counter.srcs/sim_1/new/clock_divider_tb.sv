`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2025 10:52:14
// Design Name: 
// Module Name: clock_divider_tb
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

`timescale 1ns / 1ps

module clock_divider_tb;

    logic   clk;
    logic   reset;
    logic   clk_out;
    
    clock_divider dut (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_out)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;   // 100MHz
    
    initial begin
        reset = 1;
        #100;
        reset = 0;
        
        #1000000;   // Simulate 1ms
        $display("Test finished");
        $finish;
     end
     
endmodule
