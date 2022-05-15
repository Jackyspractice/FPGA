module clock_div_1HZ(
    mclk,
    clk_out,
    clk_scan
);

input mclk;

output clk_out;
output clk_scan;

wire clk_out;
reg [26:0] q;

always @(posedge mclk)
begin
    q <= q + 1'b1;
end

assign clk_out = q[26];
assign clk_scan = q[15];

endmodule
