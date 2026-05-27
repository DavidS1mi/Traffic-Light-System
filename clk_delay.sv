`timescale 1ns / 1ps

module clk_delay(
input logic clk,
input logic rst_clk,
output logic clk_delay
    );
    
    logic [31:0] clkint;
    
    always_ff @(posedge clk)
    begin
    if(rst_clk == 1)
    clkint = 32'b0;
    else
    clkint = clkint+1;
    end
    assign clk_delay = clkint[27];
endmodule
