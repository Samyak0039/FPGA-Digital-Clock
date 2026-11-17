`timescale 1ns / 1ps

module tb_hours_counter;

    reg clk;
    reg rst;
    reg enable;

    wire [4:0] hrs;

    hours_counter DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .hrs(hrs)
    );

    // Generate 10 ns clock
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

        // Counter should hold at zero
        repeat (3) @(posedge clk);

        // Enable hours counter
        @(negedge clk);
        enable = 1;

        // Count from 0 to 23
        repeat (23) @(posedge clk);
        #1;

        // Check rollover from 23 to 0
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