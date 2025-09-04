module top(clk,reset,dm_write,LED_out,Anode_Activate);
input clk;
input reset,dm_write;

output wire [0:6] LED_out;   // segment pattern 0-f
output wire [3:0] Anode_Activate;

wire [15:0] mul;
wire [15:0] a,b,c;
wire [15:0] fma;



assign a = 16'b0100101110110100;
assign b = 16'b1000101101101110;
assign c = 16'b1101011110110111;

multiply multiplier(a,b,mul);
add adder(c,mul,fma);
seg7_driver fpga(clk,reset,dm_write,fma,LED_out,Anode_Activate);


endmodule