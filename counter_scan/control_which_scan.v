module control(
    input clk,

    output reg [1:0] sel
);

always @(posedge clk)
begin
    sel <= sel + 1;
end

endmodule
