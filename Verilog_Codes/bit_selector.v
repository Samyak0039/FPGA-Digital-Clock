module bit_selector (
    input wire [26:0] count,
    output wire clk_out
);

    assign clk_out = (count >= 27'd50000000) ? 1'b1 : 1'b0;

endmodule