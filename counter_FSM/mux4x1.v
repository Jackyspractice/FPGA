module mux4x1(
    input [7:0]in,
    input [1:0]sel,

    output reg [3:0]outp
);

always @(*)begin
    if (sel == 2'b00) outp <= in[3:0];
    if (sel == 2'b01) outp <= in[7:4];
    if (sel == 2'b10) outp <= 4'b0000;
    if (sel == 2'b11) outp <= 4'b0000;
end

endmodule
