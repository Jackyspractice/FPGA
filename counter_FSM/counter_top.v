module counter_top(
    input wire inc,
    input wire set,
    input wire clk_100M,
    input wire clr,

    output wire [6:0] out,
    output wire [3:0] scan,
    output wire [2:0] state
);

wire inc_db;
wire set_db;
wire clr_db;
wire clk_1Hz;
wire clk_scan;
wire up;
wire enable;
wire [7:0]counter_data;
wire [1:0]which;
wire [3:0]mux_out;


debounce inc_debounce(
    .inp(inc),
    .clk(clk_1Hz),

    .outp(inc_db)
);

debounce set_debounce(
    .inp(set),
    .clk(clk_1Hz),

    .outp(set_db)
);

debounce clr_debounce(
    .inp(clr),
    .clk(clk_1Hz),

    .outp(clr_db)
);

clock_div clock_div(
    .mclk(clk_100M),

    .clk_counter(clk_1Hz),
    .clk_scan(clk_scan)
);

control scan_which(
    .clk(clk_scan),

    .sel(which)
);

mux4x1 mux4x1(
    .in(counter_data),
    .sel(which),

    .outp(mux_out)
);

FSM FSM(
    //input
    .clk(clk_1Hz),
    .clr(clr_db),
    .inc(inc_db),
    .set(set_db),

    //output
    .up(up),
    .enable(enable),
    .state(state)
);

counter counter(
    //input
    .clk(clk_1Hz),
    .clr(clr_db),
    .up(up),
    .enable(enable),

    //output
    .data(counter_data)
);

sev_scan sev_scan(
    .sel(which),

    .scan(scan)
);

sev_decoder decoder(
    .x(mux_out),

    .seg(out)
);

endmodule