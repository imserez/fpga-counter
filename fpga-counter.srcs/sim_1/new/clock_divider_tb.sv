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

module clock_divider_tb;

    logic   clk;
    logic   reset;
    logic   clk_out;
    logic   [2:0] dynamic_limit_tb;     // 2 is enough for testing N(3)
    clock_divider #(.N(3), .LIMIT(5)) dut (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_out),
        .dynamic_limit(dynamic_limit_tb)
        
    );
    
    initial clk = 0;
    always #5 clk = ~clk;   // 100MHz
    
    initial begin
        reset = 1;
        dynamic_limit_tb = 'b011; // start the test at 3
        #100;
        reset = 0;
        #100;
        dynamic_limit_tb = 'b010; // testing with 2 (faster)
        #100;
        dynamic_limit_tb = 'b101;  // testing with 5 (slower)
        #100000000;   // Simulate 
        $display("Test finished");
        $finish;
     end
     
endmodule
