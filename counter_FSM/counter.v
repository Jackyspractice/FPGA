module counter(
    input wire clk,
    input wire clr,
    input wire up,
    input wire enable,

    output reg [7:0]data
);

always @(posedge clk or posedge clr) begin

    if (clr) data <= 8'b0000_0000;

    else if (enable) begin

        if (up == 1) data <= data + 1;

        else begin

            if (data == 0) data <= 8'b1111_1111;
            
            else data <= data - 1;

        end

    end
end

endmodule