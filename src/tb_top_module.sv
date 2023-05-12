`timescale 1ns / 1ps

module tb_top_module;
    logic clk;
    logic rst_switch;
    logic top_button;
    logic bottom_button;
    logic left_button;
    logic right_button;
    logic [8:0] num_max_win_switches;
    logic [3:0] game_state_leds;
    logic [6:0] display_units;
    logic [6:0] display_tens;
    logic [6:0] display_hundreds;
    logic [6:0] display_thousands;
    logic [6:0] display_ten_thousands;
    logic [6:0] display_hundred_thousands;
    logic CLK_VGA; 
    logic SYNC_H, SYNC_V, SYNC_B, SYNC_BLANK;
    logic [7:0] Red, Green, Blue;

    top_module dut (
        .clk(clk),
        .rst_switch(rst_switch),
        .top_button(top_button),
        .bottom_button(bottom_button),
        .left_button(left_button),
        .right_button(right_button),
        .num_max_win_switches(num_max_win_switches),
        .game_state_leds(game_state_leds),
        .display_units(display_units),
        .display_tens(display_tens),
        .display_hundreds(display_hundreds),
        .display_thousands(display_thousands),
        .display_ten_thousands(display_ten_thousands),
        .display_hundred_thousands(display_hundred_thousands),
        .CLK_VGA(CLK_VGA),
        .SYNC_H(SYNC_H),
        .SYNC_V(SYNC_V),
        .SYNC_B(SYNC_B),
        .SYNC_BLANK(SYNC_BLANK),
        .Red(Red),
        .Green(Green),
        .Blue(Blue)
    );

    // Clock generation
    always begin
    #5 clk = ~clk;
    end



    initial begin
		// Initialize signals
		clk = 0;
		#10
		top_button=0;
		bottom_button=0;
		left_button=0;
		right_button=0;
        num_max_win_switches=8'b10000000;
	  
		#100;
		rst_switch = 1;

		// Test process
		#100;
		rst_switch = 0;
		#100;

		$finish;

end

endmodule
