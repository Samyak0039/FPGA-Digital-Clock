module digital_clock_core (
    input wire clk_1hz,
    input wire rst,

    output wire [5:0] sec,
    output wire [5:0] min,
    output wire [4:0] hrs
);

    seconds_counter SC (
        .clk(clk_1hz),
        .rst(rst),
        .sec(sec)
    );

    minutes_counter MC (
        .clk(clk_1hz),
        .rst(rst),
        .enable(sec == 6'd59),
        .min(min)
    );

    hours_counter HC (
        .clk(clk_1hz),
        .rst(rst),
        .enable((sec == 6'd59) && (min == 6'd59)),
        .hrs(hrs)
    );

endmodule