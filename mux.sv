`timescale 1ns / 1ps

module mux(
input logic in0,
input logic in1,
input logic sel,
output logic out
    );
    
    always_comb
    begin
    if(sel == 1)
    out = in1;
    else out = in0;
    end
    
endmodule
