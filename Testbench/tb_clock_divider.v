`timescale 1ns / 1ps

module tb_clock_divider;

    reg clk;
    reg rst;
    wire clk_div;

    clock_divider DUT (
        .clk(clk),
        .rst(rst),
        .clk_div(clk_div)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 0;

        // Check counter increment
        repeat (5) @(posedge clk);
        #1;

        if (DUT.count == 27'd5)
            $display("COUNTER INCREMENT PASSED");
        else
            $display("COUNTER INCREMENT FAILED");

        // Check initial clock output
        if (clk_div == 1'b0)
            $display("INITIAL CLOCK LOW PASSED");
        else
            $display("INITIAL CLOCK LOW FAILED");

        // Move counter to terminal count
        @(negedge clk);
        DUT.C1.count = {1'b0, 26'd49999999};

        @(posedge clk);
        #1;

        if (clk_div == 1'b1)
            $display("CLOCK HIGH TOGGLE PASSED");
        else
            $display("CLOCK HIGH TOGGLE FAILED");

        if (DUT.count == {1'b1, 26'd0})
            $display("COUNTER RESET AND TOGGLE PASSED");
        else
            $display("COUNTER RESET AND TOGGLE FAILED");

        // Check second toggle
        @(negedge clk);
        DUT.C1.count = {1'b1, 26'd49999999};

        @(posedge clk);
        #1;

        if (clk_div == 1'b0)
            $display("CLOCK LOW TOGGLE PASSED");
        else
            $display("CLOCK LOW TOGGLE FAILED");

        $finish;
    end

endmodule