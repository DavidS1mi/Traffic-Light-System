`timescale 1ns / 1ps

module traffic_light(
input logic walk,
input logic rst,
input logic clk,
output logic green,
output logic red,
output logic blue
    );
    
    logic timer_done;
    logic change;
    logic [3:0] timer_value;
    logic wg;
    logic wr;
    logic wf;
    logic [2:0] wgrf;
    assign wgrf = {wg, wr, wf};
    
    traffic_light_fsm fsm0(
    .clk(clk),       
    .rst(rst),       
    .walk(walk),      
    .timer_done(timer_done),
    .green(wg),    
    .red(wr),      
    .flash(wf)     
    );
    
    ROM rom0(
    .in(wgrf),  
    .out(timer_value) 
    );
    
    change_detector change_det0(
    .clk(clk),     
    .rst(rst),     
    .in(wgrf),
    .change(change)  
    );
    
    mux mux0(
    .in0(~wg),
    .in1(clk),
    .sel(wf),
    .out(blue)
    );
    
    countdown_timer timer0(
    .clk(clk),              
    .rst(rst),              
    .timer_value(timer_value),
    .load(change),             
    .timer_done(timer_done)       
    );
    
    assign green = wg;
    assign red = wr;
    
endmodule
