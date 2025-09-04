module add(input [15:0]c,input [15:0]mul, output [15:0]fma);
reg [8:0]z;
reg [8:0]exp;
reg s;
reg [8:0] d;
reg [15:0] mul1,c1;
wire flag;

reg [7:0] sig_c;
reg [7:0] sig_mul;

always@(*)
begin
    mul1=mul;
    c1=c;

    
        if(c1[14:7]>mul1[14:7])begin
            s=c1[15];
            d=c1[14:7]-mul1[14:7];
            sig_mul = {1'b1, mul1[6:0]}>>d;
            sig_c = {1'b1, c1[6:0]}; 
        end
        else if(mul1[14:7]>c1[14:7])begin
            s=mul1[15];
            d=mul1[14:7]-c1[14:7];
            sig_c = {1'b1, c1[6:0]}>>d;
            sig_mul = {1'b1, mul1[6:0]};
        end
        else begin
                if(c1[6:0]>mul1[6:0])
                begin
                   s=c1[15];
                   sig_c = {1'b1, c1[6:0]};
                   sig_mul = {1'b1, mul1[6:0]};
                end
                else if(mul1[14:7]>c1[14:7])
                begin
                   s=mul1[15];
                   sig_c = {1'b1, c1[6:0]};
                   sig_mul = {1'b1, mul1[6:0]};
                end
                else 
                begin 
                   s=1'b0;
                   sig_c = {1'b1, c1[6:0]};
                   sig_mul = {1'b1, mul1[6:0]};
                end 
        end

    


    if(c1[15]^mul1[15])
    begin
        if(c1[15]) z = (~sig_c)+sig_mul+1'b1;
        else z= (~sig_mul)+sig_c+1'b1;
    end
    else
    begin
        z = sig_mul + sig_c;
    end
    
    if(c1[14:7]>=mul1[14:7]) exp = c1[14:7];
    else exp=mul1[14:7]; 

    if(z[8] && (c1[15]^~mul1[15]))
    begin
        exp=exp+1;
        z[6:0] = z[7:1];
    end

    
end

assign flag= exp[8] ? 1'b1 : 1'b0;
assign fma = {s,exp[7:0],z[6:0]};
endmodule