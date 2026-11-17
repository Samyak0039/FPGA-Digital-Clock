`timescale 1ns / 1ps

module tb_digital_clock_core;

    reg clk_1hz;
    reg rst;

    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hrs;

    digital_clock_core DUT (
        .clk_1hz(clk_1hz),
        .rst(rst),
        .sec(sec),
        .min(min),
        .hrs(hrs)
    );

    // Generate simulation clock
    always #5 clk_1hz = ~clk_1hz;

    initial
    begin
        clk_1hz = 0;
        rst = 1;

        // Apply reset
        repeat (2) @(posedge clk_1hz);
        @(negedge clk_1hz);
        rst = 0;

        // Check initial time
        #1;
        $display("Initial Time = %0d:%0d:%0d",
                 hrs, min, sec);

        // Wait until 23:59:59
        repeat (86399) @(posedge clk_1hz);
        #1;

        $display("Before rollover = %0d:%0d:%0d",
                 hrs, min, sec);

        // Check 23:59:59
        if (hrs == 23 && min == 59 && sec == 59)
            $display("23:59:59 CHECK PASSED");
        else
            $display("23:59:59 CHECK FAILED");

        // One more clock edge
        @(posedge clk_1hz);
        #1;

        $display("After rollover = %0d:%0d:%0d",
                 hrs, min, sec);

        // Check complete clock rollover
        if (hrs == 0 && min == 0 && sec == 0)
            $display("24-HOUR ROLLOVER PASSED");
        else
            $display("24-HOUR ROLLOVER FAILED");

        #10;
        $finish;
    end

endmodule