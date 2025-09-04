module multiply(input [15:0]a, input[15:0]b, output [15:0]mul);


wire [13:0]p1;
wire [7:0]temp;
wire [14:0]temp2;

assign p1[13:0]= a[6:0] * b[6:0];
assign temp[7:0] = a[6:0] + b[6:0];
assign flag1 = temp[7];
assign temp2[14:0] = {temp[6:0],7'b0000000} + p1;
assign flag2 = temp2[14];

assign mul[6:0] = (flag1|flag2) ? {(flag1&flag2), temp2[13:8]} : temp2[13:7] ;

assign mul[15] = a[15]^b[15];

assign mul[14:7] = a[14:7] + b[14:7]+ (flag1|flag2);

endmodule