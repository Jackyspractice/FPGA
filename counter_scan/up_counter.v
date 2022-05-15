module counter(

input wire [7:0]data,
input wire clr,
input wire clk,
input wire enable,
input wire load,
input wire choose,

output reg [7:0] q );

reg mode;

always @(posedge clk or posedge clr or posedge load)
//problem: when accedicent push error button, the counter will still react
//solution: ?
//enable: switch
begin

    if (enable) begin //enable is on 

        if (q == 0 && mode == 1)
            q <= 8'b1111_1111;
        
        else if (clr) begin
            q <= 8'b0000_0000;
            mode <= 0; //up
        end
        else if (load == 1)
            q <= data;
        else if (mode == 0)
            q <= q + 1;
        else if (mode == 1)
            q <= q - 1;
    end
    
end

always @(posedge choose) mode <= mode + 1;


endmodule