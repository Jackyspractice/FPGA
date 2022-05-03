//`timescale 1ns/1ps

module counter_top(
    input wire clk,//100MHz
    input wire clr,
    input wire btn,
    output wire [6:0] out
);
//input

//function output
wire clk_1HZ;
wire btn_db;//change mode
wire [3:0] data;
//real output

//uut
debounce db(
    .inp(btn),
    .clk(clk),
    .clr(clr),

    .outp(btn_db)
);

clock_div_1HZ clkdiv(
    .mclk(clk),
    .clr(clr),

    .clk_out(clk_1HZ)
);

counter_4bit counter(
    .clr(clr),
    .clk(clk_1HZ),
    .choose(btn_db),

    .q(data)
);

sev_decoder decoder(
    .x(data),

    .seg(out)
);

/*initial begin
    //initialize
    clr = 1;
    clk = 0;
    btn = 1;
    #10
    clr = 0;
    //strat
    
end

always #5 clk = ~clk;*/

endmodule
