module counter_4bit(

input wire clr,
input wire clk,
input wire choose,

output reg [3:0] q );

reg mode;

always @(posedge clk or posedge clr)
begin 
    if (choose == 1)
        mode <= mode + 1;

    if (q == 0 && mode == 1)
         q <= 4'b1111;
    
    if (clr) begin
        q <= 4'b0000;
        mode <= 0; //up
    end
    else if (mode == 0)
        q <= q + 1;
    else if (mode == 1)
        q <= q - 1;
end

endmodule