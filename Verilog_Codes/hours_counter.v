module hours_counter (
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [4:0] hrs
);

    always @(posedge clk)
    begin
        if (rst)
            hrs <= 5'd0;
        else if (enable)
        begin
            if (hrs == 5'd23)
                hrs <= 5'd0;
            else
                hrs <= hrs + 1'b1;
        end
    end

endmodule