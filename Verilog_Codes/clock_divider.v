module clock_divider (
    input wire clk,
    input wire rst,
    output wire clk_div
);

    wire [26:0] count;
    wire clk_div_raw;

    counter_27bit C1 (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    bit_selector B1 (
        .count(count),
        .clk_out(clk_div_raw)
    );

    BUFG clk_div_buf (
        .I(clk_div_raw),
        .O(clk_div)
    );

endmodule