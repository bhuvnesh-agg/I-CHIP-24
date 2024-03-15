module float_multiplier_32bit(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result
);

// Sign bit
reg sign_a;
reg sign_b;
reg sign_result;

// Exponent bits
reg [7:0] exp_a;
reg [7:0] exp_b ;
reg [7:0] exp_result;
reg [3:0] i;

// Mantissa bits
reg [22:0] mant_a;
reg [22:0] mant_b ;
reg [47:0] mant_result ;

// Normalization
reg [24:0] mant_result_norm;
reg [7:0] exp_result_norm;
always @(*) begin
sign_a = a[31];
sign_b = b[31];
sign_result = sign_a ^ sign_b;
exp_a = a[30:23];
exp_b = b[30:23];
exp_result = exp_a + exp_b - 127;
mant_a = a[22:0];
mant_b = b[22:0];
mant_result = {1'b1, mant_a} * {1'b1, mant_b};
    $display("%b",mant_result);

    if (mant_result[47] == 1'b1) begin
        // Shift mantissa left
//        for(i=0;mant_result[47]==0 ;i=i+1) begin
            mant_result_norm = mant_result[47:22];
            exp_result_norm = exp_result+1;
            $display("%b",mant_result_norm);
//        end
    end else if(mant_result[46]==1'b1) begin
        // Shift mantissa right
        mant_result_norm = mant_result[46:21];
        exp_result_norm = exp_result ;
        $display("%b",mant_result_norm);
    end
    else
    begin
        for (i = 0; i < 48 && mant_result[46] == 1'b1; i = i + 1) begin
                  mant_result =mant_result<<1; // Shift left by 1
                  exp_result_norm = exp_result_norm - 1'b1; // Decrement exponent
        end

        mant_result_norm = mant_result[46:21];
        $display("mant_result_m=norm %b",mant_result_norm);
    end
    if(mant_result_norm[1]==1)begin
        mant_result_norm=mant_result_norm+2'b10;
    end
    if(mant_result_norm[0]==1)begin
        mant_result_norm=mant_result_norm+2'b01;
    end
    
    if(mant_result_norm[1]==1)begin
        mant_result_norm=mant_result_norm+2'b10;
    end

end

// Result assembly
always @* begin
        
    if (exp_result_norm >= 255) begin
        // Overflow/Infinity
        result = {1'b0, 8'hFF, 23'hFF};
    end else if (exp_result_norm <= 0) begin
        // Underflow/Zero/Denormalized
        result = {sign_result, 1'b0, 23'h00};
    end else begin
        // Normalized result
        $display("%b %b",exp_result_norm,mant_result_norm);
        result = {sign_result, exp_result_norm, mant_result_norm[24:2]};
        $display("%b",result);
    end
end

endmodule
