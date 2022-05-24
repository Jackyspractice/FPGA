module FSM (
    input wire clk,
    input wire clr,
    input wire inc,
    input wire set,

    output reg up,
    output reg enable,
    output reg [2:0]state
);

parameter idle = 0, up_mode = 1, set_mode = 2,
enable_pulse = 3, down_mode = 4;

initial 
    begin
        state = idle;
end

reg [2:0]stateNext;

 always @(posedge clk) begin
        if (clr)
            state <= idle;
        else
            state <= stateNext;
end

always @(state, inc, set) begin

    case (state)

        idle: begin
            enable <= 0;
            up <= 0;
            stateNext = idle;

            if (inc == 1 && set == 0) stateNext = up_mode;

        end

        up_mode: begin
            enable <= 1;
            up <= 1;
            stateNext = up_mode;

            if (inc == 0 && set == 1) stateNext = set_mode;
        end

        set_mode: begin
            enable <= 0;
            up <= 0;
            stateNext = set_mode;

            if (inc == 1 && set == 0) stateNext = enable_pulse;
            if (inc == 0 && set == 1) stateNext = up_mode;
            else if (inc == 1 && set == 1) stateNext = down_mode;
        end

        enable_pulse: begin
            enable <= 1;
            up <= 1;

            stateNext = set_mode;
        end

        down_mode: begin
            enable <= 1;
            up <= 0;
            stateNext = down_mode;

            if (inc == 0 && set == 1) stateNext = set_mode;
            else if (inc == 1 && set == 1) stateNext = idle;
        end

    endcase

end
    
endmodule