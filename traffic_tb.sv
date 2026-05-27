`timescale 1ns / 1ps

module traffic_tb();

logic walk;  
logic rst;  
logic clk;   
logic green;
logic red;  
logic blue;  

traffic_light tftb(
.walk(walk),
.rst(rst),  
.clk(clk),  
.green(green),
.red(red),  
.blue(blue) 
);

initial
begin
	clk = 0;
	forever
		begin
		#5 clk = ~clk;
		end
end

initial 
begin
rst <= 1;
walk <= 0;
@(posedge clk);
rst = 0;
@(posedge clk);
walk <= 1;
@(posedge clk);
walk <= 0;

repeat(20) begin
@(posedge clk);
end
walk<=1;
@(posedge clk);
walk<= 0;
repeat(20) begin
@(posedge clk);
end
$stop;
end
endmodule
