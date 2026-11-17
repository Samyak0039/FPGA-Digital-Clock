`timescale 1ns / 1ps

module tb_minutes_counter;

    reg clk;
    reg rst;
    reg enable;

    wire [5:0] min;

    minutes_counter DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .min(min)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        rst = 1;
        enable = 0;

        // Apply reset
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 0;

        // Check that counter holds when enable is LOW
        repeat (3) @(posedge clk);
        #1;

        // Enable minutes counter
        @(negedge clk);
        enable = 1;

        // Count from 0 to 59
        repeat (59) @(posedge clk);
        #1;

        // One more clock: 59 returns to 0
        @(posedge clk);
        #1;

        // Disable counter
        @(negedge clk);
        enable = 0;

        repeat (3) @(posedge clk);

        #10;
        $finish;
    end

endmodule