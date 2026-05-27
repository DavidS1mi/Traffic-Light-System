`timescale 1ns / 1ps

module traffic_light_fsm(
input logic clk,
input logic rst,
input logic walk,
input logic timer_done,
output logic green,
output logic red,
output logic flash
    );
    
localparam green_state = 2'b00;
localparam yellow_state = 2'b01;
localparam red_state = 2'b10;
localparam flash_state = 2'b11;

logic [1:0] state, state_next;
    
    always_ff @(posedge clk) begin
    if(rst == 1)
        state <= green_state;
    else
        state <= state_next;
end
    
    always_comb begin
    state_next = state;
    case(state)
        green_state: begin
                         if(walk == 1) state_next = yellow_state;
                     end
        yellow_state: begin
                         if(timer_done == 1) state_next = red_state;
                     end
        red_state: begin
                        if(timer_done == 1) state_next = flash_state;
                    end
        flash_state: begin
                        if(timer_done == 1) state_next = green_state;
                        end
        default: state_next = green_state;
    endcase
end
assign green = (state == green_state || state == yellow_state);
assign red = ~(state == green_state);
assign flash = (state ==flash_state);
endmodule
