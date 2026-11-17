module minutes_counter (
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [5:0] min
);

    always @(posedge clk)
    begin
        if (rst)
            min <= 6'd0;
        else if (enable)
        begin
            if (min == 6'd59)
                min <= 6'd0;
            else
                min <= min + 1'b1;
        end
    end

endmodule
