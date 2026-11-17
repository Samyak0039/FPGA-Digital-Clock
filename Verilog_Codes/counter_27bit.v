module counter_27bit (
    input wire clk,
    input wire rst,
    output reg [26:0] count
);

    always @(posedge clk)
    begin
        if (rst)
            count <= 27'd0;

        else if (count[25:0] == 26'd49999)
            count <= {~count[26], 26'd0};

        else
            count <= {count[26], count[25:0] + 1'b1};
    end

endmodule