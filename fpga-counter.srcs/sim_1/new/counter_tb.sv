`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.12.2025 10:19:47
// Design Name: 
// Module Name: counter_tb
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


module counter_tb;
    
    localparam SIZE = 16;
    logic clk;
    logic reset;
    logic enable;
    logic [SIZE-1:0] count;
    
    // Instanciar el contador
    counter #(.N(SIZE))dut (
        .clk(clk),
        .reset(reset),
        .count(count),
        .enable(enable)
    );
    
    // Generar reloj (10ns periodo)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test
    initial begin
        reset = 1;
        enable = 0;
        #20;
        reset = 0;
        enable = 1;
        #200
        enable = 0;
        #20
        enable = 1;
        #420;
        $display("Before reset: count=%d", count);
        reset = 1;
        #200;
        reset = 0;
        #1000;
        $display("After reset: count=%d", count);
        $display("Simulacion finished OK: count=%d", count);
        $finish;
    end
    
endmodule
