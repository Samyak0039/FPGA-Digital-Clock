`timescale 1ns / 1ps

module tb_seconds_counter;

    reg clk;
    reg rst;

    wire [5:0] sec;

    seconds_counter DUT (
        .clk(clk),
        .rst(rst),
        .sec(sec)
    );

    // Generate clock with 10 ns period
    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        rst = 1;

        #20;
        rst = 0;

        // Wait for 65 clock cycles
        repeat (65) @(posedge clk);

        #10;
        $finish;
    end

endmodule
