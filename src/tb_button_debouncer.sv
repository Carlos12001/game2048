`timescale 1ns / 1ps

module tb_button_debouncer;
    logic clk,reset,button_in,button_out;
    button_debouncer uut(
        .clk(clk),
        .reset(reset),
        .button_in(button_in),
        .button_out(button_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialization
        clk = 0;
        reset = 0;
        button_in = 1;
        #50;
        
        // Release reset
        reset = 1;
        #50;
        
        // Test pressing and releasing the button
        button_in = 0; // Press button
        #100;
        
        button_in = 1; // Release button
        #10;
        
        // Check button_out value after pressing and releasing
        if(button_out !== 1) begin
            $display("Test failed at time %t. Expected button_out = 1, but got button_out = %b", $time, button_out);
        end else begin
            $display("Test passed at time %t. button_out = %b", $time, button_out);
        end

        // Test pressing and releasing the button again
        button_in = 0; // Press button
        #10;
        
        button_in = 1; // Release button
        #10;
        
        // Check button_out value after pressing and releasing again
        if(button_out !== 1) begin
            $display("Test failed at time %t. Expected button_out = 1, but got button_out = %b", $time, button_out);
        end else begin
            $display("Test passed at time %t. button_out = %b", $time, button_out);
        end

        $finish;
    end
endmodule
