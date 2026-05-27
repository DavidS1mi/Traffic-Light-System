`timescale 1ns / 1ps

module top(
input logic clk,
input logic rst_clk,
input logic rst_tf,
input logic walk,
output logic clk_delay,
output logic green,
output logic red,
output logic blue
    );
    
    clk_delay clk_delay0(
    .clk(clk),      
    .rst_clk(rst_clk),  
    .clk_delay(clk_delay)
    );
    
    traffic_light dut(
    .walk(walk),  
    .rst(rst_tf),   
    .clk(clk_delay),   
    .green(green),
    .red(red),  
    .blue(blue)  
    );
    
endmodule
