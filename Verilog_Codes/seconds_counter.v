`timescale 1ns / 1ps
module seconds_counter(
    input clk,
    input rst,
    output reg [5:0] sec
    );
     always @(posedge clk)
    begin
        if (rst)
            sec <= 6'd0;
        else if (sec == 6'd59)
            sec <= 6'd0;
        else
            sec <= sec + 1'b1;
    end
endmodule
