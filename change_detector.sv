`timescale 1ns / 1ps

module change_detector(
input logic clk,
input logic rst,
input logic [2:0] in,
output logic change
    );
    
    logic [2:0] register;
    
    always_ff @(posedge clk) begin
    if(rst)
        begin
    change <= 0;
    register <= 0;
        end
    else begin
    if(in != register)
    begin
    change <= 1;
    end
     else change <= 0;
    end
   
    register <= in;
    end
    
endmodule
