//`timescale 1ns/1ps
//problem: the mode change took too long , need to use faster clk speed
//solution: using posedge of changing mode, no need to input another clk 

//problem: Does clr need debounce?
//solution:

module counter_top(
    input wire clk,//100MHz
    input wire clr,
    input wire btn,//choose
    input wire [7:0] data,//switch input 
    input wire load,
    input wire enable,
    output wire [6:0] out,
    output wire [3:0] scan
);
//input

//function output
wire clk_1HZ;
wire btn_db;//change mode
wire load_db;
wire [7:0] data_out;
wire [3:0] mux_out;
wire [1:0] which;
//real output

//uut
control scan_which(
    .clk(clk),

    .sel(which)
);

mux4to1 mux(
    .in(data_out),
    .sel(which),

    .outp(mux_out)
);

sev_scan sev_scan(
    .sel(which),

    .scan(scan)
);

debounce db_choose(
    .inp(btn),
    .clk(clk),
    .clr(clr),

    .outp(btn_db)
);

debounce db_load(
    .inp(load),
    .clk(clk),
    .clr(clr),

    .outp(load_db)
);

clock_div_1HZ clkdiv(
    .mclk(clk),
    .clr(clr),

    .clk_out(clk_1HZ)
);

counter counter(
    .data(data),
    .load(load_db),
    .enable(enable),
    .clr(clr),
    .clk(clk_1HZ),
    .choose(btn_db),

    .q(data_out)
);

sev_decoder decoder(
    .x(mux_out),

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