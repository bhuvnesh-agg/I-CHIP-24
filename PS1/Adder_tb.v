module testbench;

    // Parameters
    parameter CLOCK_PERIOD = 10; // Clock period in time units

    // Signals
    reg [31:0] a, b;
    wire [31:0] result;
    reg clk;

    // Instantiate the module under test
    Floating_point_adder dut(
        .a(a),
        .b(b),
        .result(result)
    );

    // Clock generation
    always #((CLOCK_PERIOD/2)) clk = ~clk;

    // Stimulus
    initial begin
        // Initialize inputs
        a = 32'b01000000101000000000000000000000; // 1.0
        b = 32'b01000000010000000000000000000000;//01000010110010000000000000000000; // 2.0
        clk = 0;


        // End simulation
        #10;
        $finish;
    end

endmodule
