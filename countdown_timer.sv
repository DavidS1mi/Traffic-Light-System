`timescale 1ns / 1ps

module countdown_timer(
input logic clk,
input logic rst,
input logic [3:0] timer_value,
input logic load,
output logic timer_done
    );
    logic [3:0] count;
    
    always_ff @(posedge clk)
    begin
    if(rst) begin
    count<= 4'b1111;
    timer_done <= 0;
    end
    else 
    if(load == 1)
    begin
    count <= timer_value;
    timer_done <= 0;
    end
    else begin
    if(count != 0)begin
    count <= count - 1;
    end
    if(count == 4'b0001)
    begin
    timer_done <= 1;
    end
    else begin timer_done <= 0;
    end
    end
    end
endmodule
