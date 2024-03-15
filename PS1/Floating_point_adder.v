//module Floating_point_adder(
//    input [31:0] a,
//    input [31:0] b,
//    output reg [31:0] result
//    );
//    reg sign_a;
//    reg [7:0] exponent_a;
//    reg [22:0] fraction_a;
//    always @(*) 
//    begin
//        sign_a = a[31];
//        exponent_a = a[30:23];
//        fraction_a = a[22:0];
//    end
//    reg sign_b;
//    reg [7:0] exponent_b;
//    reg [22:0] fraction_b;
//    always @(*) 
//    begin
//        sign_b = b[31];
//        exponent_b = b[30:23];
//        fraction_b = b[22:0];
//    end
//    reg [22:0] shifted_fraction;
//    reg [7:0] larger_exponent;
//    reg [24:0] final_fraction;
//    reg final_sign;
//    always @(*) 
//    begin
//        if (exponent_a > exponent_b) 
//        begin
//            if(sign_a==sign_b)
//            begin
//                larger_exponent=exponent_a;
//                shifted_fraction = {1'b1, fraction_b} >> (exponent_a - exponent_b);
//                final_sign=sign_a;
//                final_fraction = {1'b1,fraction_a} + shifted_fraction;
//                if(final_fraction[24]==1) 
//                begin
//                    final_fraction=final_fraction<<1;
//                    larger_exponent = exponent_a+1;
//                end
//                else if(final_fraction[23]==1)
//                begin
//                    final_fraction=final_fraction<<2;
//                end
                
//            else
//            begin
//                final_sign=sign_a;
//                larger_exponent=exponent_a;
//                shifted_fraction={1'b1, fraction_b} >>(exponent_a-exponent_b);
//                final_fraction=({1'b1,fraction_a}-shifted_fraction)<<1;
//                for(i=0;final_fraction[23]==0;i=i+1)
//                begin
//                    final_fraction=final_fraction<<1;
//                    larger_exponent=larger_exponent-1;
//                end
//                final_fraction=final_fraction<<1;
//            end
//        end
//        else
//        begin
//            if(sign_a==sign_b)
//            begin
//                final_sign=sign_a;
//                larger_exponent=exponent_b;
//                shifted_fraction={1'b1,fraction_a}>>(exponent_b-exponent_a);
//                final_fraction={1'b1,fraction_b}+shifted_fraction;
//                if(final_fraction[24]==1) 
//                begin
//                    final_fraction=final_fraction<<1;
//                    larger_exponent = exponent_b+1;
//                end
//                else if(final_fraction[23]==1)
//                begin
//                    final_fraction=final_fraction<<2;
//                end
//            else
//            begin
//                final_sign=sign_b;
//                larger_exponent=exponent_b;
//                shifted_fraction={1'b1,fraction_a}>>(exponent_b-exponent_a);
//                final_fraction={1'b1,fraction_b}-shifted_fraction;
//                final_fraction=({1'b1,fraction_a}-shifted_fraction)<<1;
//                for(i=0;final_fraction[23]==0;i=i+1)
//                begin
//                    final_fraction=final_fraction<<1;
//                    larger_exponent=larger_exponent-1;
//                end
//                final_fraction=final_fraction<<1;
//            end
//        end
//        result[31] = final_sign; // Result sign
//        result[30:23] = larger_exponent; // Result exponent
//        result[22:0] = final_fraction[24:2]; // Result fraction
//    end

//endmodule


//module Floating_point_adder(
//    input [31:0] a,
//    input [31:0] b,
//    output reg [31:0] result
//    );

//    reg sign_a;
//    reg [7:0] exponent_a;
//    reg [22:0] fraction_a;
    
//    always @(*) begin
//        sign_a = a[31];
//        exponent_a = a[30:23];
//        fraction_a = a[22:0];
//    end
    
//    reg sign_b;
//    reg [7:0] exponent_b;
//    reg [22:0] fraction_b;
    
//    always @(*) begin
//        sign_b = b[31];
//        exponent_b = b[30:23];
//        fraction_b = b[22:0];
//    end
    
//    reg [22:0] shifted_fraction;
//    reg [7:0] larger_exponent;
//    reg [24:0] final_fraction;
//    reg final_sign;
//    reg i;
    
//    always @(*) begin
//        if(exponent_a == exponent_b)
//        begin
//            if (sign_a == sign_b) begin
//                final_sign = sign_a;
//                larger_exponent = exponent_b;
//                shifted_fraction = {1'b1, fraction_a} >> (exponent_b - exponent_a);
//                final_fraction = {1'b1, fraction_b} + shifted_fraction;
//                if (final_fraction[24]) begin
//                    final_fraction = final_fraction << 1;
//                    larger_exponent = exponent_b + 1;
//                end
//                else if (final_fraction[23]) begin
//                    final_fraction = final_fraction << 2;
//                end
//            else 
//            begin
//                if(fraction_a==fraction_b) begin
//                    larger_exponent=8'b00000000;
//                    final_sign=1'b0;
//                    final_fraction=23'b00000000000000000000000;
//                end
//                else if(fraction_a>fraction_b)
//                begin
//                    larger_exponent=exponent_a;
//                    final_sign=sign_a;
//                    final_fraction=fraction_a-fraction_b;
//                    final_fraction=final_fraction<<1;
//                    for (i=0; final_fraction[23] == 0; i=i+1)
//                    begin
//                        final_fraction=final_fraction<<1;
//                        final_exponent=final_exponent-1;
//                    end
//                    final_fraction=final_fraction<<1;
//                end
//                else
//                begin
//                    larger_exponent=exponent_b;
//                    final_sign=sign_b;
//                    final_fraction={1'b1, fraction_b}-{1'b1,fraction_a};
//                    final_fraction=final_fraction<<1;
//                    for (i=0; final_fraction[23] == 0; i=i+1)
//                    begin
//                        final_fraction=final_fraction<<1;
//                        final_exponent=final_exponent-1;
//                    end
//                    final_fraction=final_fraction<<1;
//                end
//            end
//        end
//        else if (exponent_a > exponent_b) begin
//            if (sign_a == sign_b) begin
//                larger_exponent = exponent_a;
//                shifted_fraction = {1'b1, fraction_b} >> (exponent_a - exponent_b);
//                final_sign = sign_a;
//                final_fraction = {1'b1, fraction_a} + shifted_fraction;
//                if (final_fraction[24]) begin
//                    final_fraction = final_fraction << 1;
//                    larger_exponent = exponent_a + 1;
//                end
//                else if (final_fraction[23]) begin
//                    final_fraction = final_fraction << 2;
//                end
//            end
//            else begin
//                final_sign = sign_a;
//                larger_exponent = exponent_a;
//                shifted_fraction = {1'b1, fraction_b} >> (exponent_a - exponent_b);
//                final_fraction = ({1'b1, fraction_a} - shifted_fraction) << 1;
//                for (i=0; final_fraction[23] == 0; i=i+1) begin
//                    final_fraction = final_fraction << 1;
//                    larger_exponent = larger_exponent - 1;
//                end
//                final_fraction = final_fraction << 1;
//            end
//        end
//        else begin
//            if (sign_a == sign_b) begin
//                final_sign = sign_a;
//                larger_exponent = exponent_b;
//                shifted_fraction = {1'b1, fraction_a} >> (exponent_b - exponent_a);
//                final_fraction = {1'b1, fraction_b} + shifted_fraction;
//                if (final_fraction[24]) begin
//                    final_fraction = final_fraction << 1;
//                    larger_exponent = exponent_b + 1;
//                end
//                else if (final_fraction[23]) begin
//                    final_fraction = final_fraction << 2;
//                end
//            end
//            else begin
//                final_sign = sign_b;
//                larger_exponent = exponent_b;
//                shifted_fraction = {1'b1, fraction_a} >> (exponent_b - exponent_a);
//                final_fraction = {1'b1, fraction_b} - shifted_fraction;
//                for (i=0; final_fraction[23] == 0; i=i+1) begin
//                    $display("hello");
//                    final_fraction = final_fraction << 1;
//                    larger_exponent = larger_exponent - 1;
//                end
//                final_fraction = final_fraction << 1;
//            end
//        end
//        result[31] = final_sign; // Result sign
//        result[30:23] = larger_exponent; // Result exponent
//        result[22:0] = final_fraction[23:1]; // Result fraction
//    end

//endmodule


module Floating_point_adder(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result
    );

    reg sign_a;
    reg [7:0] exponent_a;
    reg [22:0] fraction_a;
    
    always @(*) begin
        sign_a = a[31];
        exponent_a = a[30:23];
        fraction_a = a[22:0];
    end
    
    reg sign_b;
    reg [7:0] exponent_b;
    reg [22:0] fraction_b;
    
    always @(*) begin
        sign_b = b[31];
        exponent_b = b[30:23];
        fraction_b = b[22:0];
    end
    
    reg [23:0] shifted_fraction;
    reg [7:0] larger_exponent;
    reg [24:0] final_fraction;
    reg final_sign;
    reg [3:0] i; // Changed width to 4 bits

    always @(*) begin
        if(exponent_a == exponent_b) begin
            if (sign_a == sign_b) begin
                final_sign = sign_a;
                larger_exponent = exponent_b;
                shifted_fraction = {1'b1, fraction_a} >> (exponent_b - exponent_a);
                final_fraction = {1'b1, fraction_b} + shifted_fraction;
                $display("%b",final_fraction);
                if (final_fraction[24]) begin
                    final_fraction = final_fraction << 1;
                    larger_exponent = exponent_b + 1;
                end
                else if (final_fraction[23]) begin
                    final_fraction = final_fraction << 2;
                end
            end
            else begin
                if(fraction_a==fraction_b) begin
                    larger_exponent=8'b00000000;
                    final_sign=1'b0;
                    final_fraction=23'b00000000000000000000000;
                end
                else if(fraction_a>fraction_b) begin
                    larger_exponent=exponent_a;
                    final_sign=sign_a;
                    final_fraction=fraction_a-fraction_b;
                    final_fraction=final_fraction<<1;
                    for (i=0; final_fraction[23] == 0 && i < 16; i=i+1) begin
                        final_fraction=final_fraction<<1;
                        larger_exponent=larger_exponent-1;
                    end
                    final_fraction=final_fraction<<1;
                end
                else begin
                    larger_exponent=exponent_b;
                    final_sign=sign_b;
                    final_fraction={1'b1, fraction_b}-{1'b1,fraction_a};
                    final_fraction=final_fraction<<1;
                    for (i=0; final_fraction[23] == 0 && i < 16; i=i+1) begin
                        final_fraction=final_fraction<<1;
                        larger_exponent=larger_exponent-1;
                    end
                    final_fraction=final_fraction<<1;
                end
            end
        end
        else if (exponent_a > exponent_b) begin
            if (sign_a == sign_b) begin
                larger_exponent = exponent_a;
                $display("%d\n",exponent_a-exponent_b);
                $display("%b\n",{1'b1, fraction_b}>> (exponent_a - exponent_b));
                shifted_fraction = {1'b1, fraction_b} >> (exponent_a - exponent_b);
                final_sign = sign_a;
                final_fraction = {1'b1, fraction_a} + shifted_fraction;
                $display("%b  %b\n",shifted_fraction,final_fraction);

                if (final_fraction[24]==1) begin
                    final_fraction = final_fraction << 1;
                    larger_exponent = exponent_a + 1;
                end
                else if (final_fraction[23]==1) begin
                    final_fraction = final_fraction << 2;
                end
                $display("%b",final_fraction);
            end
            else begin
                final_sign = sign_a;
                larger_exponent = exponent_a;
                shifted_fraction = {1'b1, fraction_b} >> (exponent_a - exponent_b);
                $display("%b",shifted_fraction);
                final_fraction = ({1'b1, fraction_a} - shifted_fraction);
                $display("\n%b",final_fraction);
                if(final_fraction[23]==1)
                begin
                    final_fraction=final_fraction<<2;
                end
                else
                begin
                    for (i=0; final_fraction[23] == 0 && i < 16; i=i+1) begin
                        final_fraction = final_fraction << 1;
                        larger_exponent = larger_exponent - 1;
                    end
                    $display("%b",final_fraction);
                    final_fraction = final_fraction << 2;
                end
            end
            $display("%b",final_fraction);
        end
        else begin
            if (sign_a == sign_b) begin
                final_sign = sign_a;
                larger_exponent = exponent_b;
                shifted_fraction = {1'b1, fraction_a} >> (exponent_b - exponent_a);
                final_fraction = {1'b1, fraction_b} + shifted_fraction;
                if (final_fraction[24]) begin
                    final_fraction = final_fraction << 1;
                    larger_exponent = exponent_b + 1;
                end
                else if (final_fraction[23]) begin
                    final_fraction = final_fraction << 2;
                end
            end
            else begin
                final_sign = sign_b;
                larger_exponent = exponent_b;
                shifted_fraction = {1'b1, fraction_a} >> (exponent_b - exponent_a);
                $display("%b\n",shifted_fraction);
                final_fraction = {1'b1, fraction_b} - shifted_fraction;
                $display("%b",final_fraction);
                if(final_fraction[23]==1)
                begin
                    final_fraction=final_fraction<<2;
                end
                else
                begin
                    for (i=0; final_fraction[23] == 0 && i < 16; i=i+1) begin
                        final_fraction = final_fraction << 1;
                        larger_exponent = larger_exponent - 1;
                    end
                    final_fraction = final_fraction << 2;
                end
                $display("%b",final_fraction);
            end
        end
        result[31] = final_sign; // Result sign
        result[30:23] = larger_exponent; // Result exponent
        result[22:0] = final_fraction[24:2]; // Result fraction
    end

endmodule
