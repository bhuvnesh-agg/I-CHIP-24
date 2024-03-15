module float_multiplier_32bit_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg rst;
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;

    // Instantiate the DUT
    float_multiplier_32bit dut (
        .a(a),
        .b(b),
        .result(result)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Reset generation
    initial begin
        rst = 1;
        #100; // Reset for 100 ns
        rst = 0;
    end

    // Test vectors
    initial begin
        $display("Starting testbench...");

        // Test 1: 1.5 * -3
        a = 32'b11000000000101011100001010001111; // 1.5 in IEEE 754 format
        b = 32'b11000000010100110011001100110011; // -3 in IEEE 754 format
        #100;
        $display("Result of 1.5 * -3 = %h", result);

        // Add more test vectors here...

        // End simulation
        #100;
        $display("End of simulation");
        $finish;
    end

endmodule


