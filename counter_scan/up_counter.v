module counter(

input wire [7:0]data,
input wire clr,
input wire clk,
input wire enable,
input wire load,
input wire choose,

output reg [7:0] q );

reg mode;

always @(posedge clk or posedge load or posedge clr) begin

    if (clr) q <= 0;

    else if (load) q <= data;

    else if (enable) begin

        if (mode == 0) q <= q + 1;

        else begin

            if (q == 0) q <= 8'b1111_1111;

            else q <= q - 1;

        end
    end


end

always @(posedge choose or posedge clr) begin

    if (clr) mode <= 0;

    else if (choose) mode <= mode + 1;

end

endmodule