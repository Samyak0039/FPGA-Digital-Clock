module digital_clock_top (
    input wire clk_100MHz,
    input wire rst
);

    wire rst_internal;
    wire clk_div;

    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hrs;

    assign rst_internal = ~rst;

    clock_divider CD (
        .clk(clk_100MHz),
        .rst(rst_internal),
        .clk_div(clk_div)
    );

    digital_clock_core DC (
        .clk_1hz(clk_div),
        .rst(rst_internal),
        .sec(sec),
        .min(min),
        .hrs(hrs)
    );

    ila_0 ILA (
        .clk(clk_100MHz),
        .probe0(sec),
        .probe1(min),
        .probe2(hrs)
    );

endmodule