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


`timescale 1ns / 1ps

module counter_tb;
    
    logic clk;
    logic reset;
    logic [15:0] count;
    
    // Instanciar el contador
    counter dut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );
    
    // Generar reloj (10ns periodo)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test
    initial begin
        reset = 1;
        #20;
        reset = 0;
        #42;
        $display("Before reset: count=%d", count);
        reset = 1;
        #20;
        reset = 0;
        #100;
        $display("After reset: count=%d", count);
        $display("Simulacion finished OK: count=%d", count);
        $finish;
    end
    
endmodule
