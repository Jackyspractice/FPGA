module clock_div(
    mclk,
    clk_counter,
    clk_scan
);

input mclk;

output clk_counter;
output clk_scan;

reg [26:0] q;

always @(posedge mclk)
begin
    q <= q + 1'b1;
end

assign clk_counter = q[26]; //1Hz
assign clk_scan = q[15];

endmodule
