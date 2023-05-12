module top_module (
	input logic clk,
	input logic rst_switch,
	input logic top_button,
	input logic bottom_button,
	input logic left_button,
	input logic right_button,
	input logic [8:0] num_max_win_switches,
	output logic [9:0] game_state_leds,
	output logic [6:0] display_units,
	output logic [6:0] display_tens,
	output logic [6:0] display_hundreds,
	output logic [6:0] display_thousands,
	output logic [6:0] display_ten_thousands,
	output logic [6:0] display_hundred_thousands,
	output logic CLK_VGA, 
   output logic SYNC_H, SYNC_V, SYNC_B, SYNC_BLANK, 
   output logic [7:0] Red, Green, Blue
);

	// Variables internas
	logic [11:0] num_max_win = 12'b100000000000;
	logic [3:0] direction;
	logic [11:0] board[3:0][3:0];
	logic [19:0] score;
	logic [1:0] game_state;
	logic [3:0] num_units;
	logic [3:0] num_tens;
	logic [3:0] num_hundreds;
	logic [3:0] num_thousands;
	logic [3:0] num_ten_thousands;
	logic [3:0] num_hundred_thousands;
	/*
		button_debouncer bd_top (
		.clk(clk),
		.reset(rst_switch),
		.button_in(top_button),
		.button_out(direction[0])
	);
	button_debouncer bd_bottom (
		.clk(clk),
		.reset(rst_switch),
		.button_in(bottom_button),
		.button_out(direction[1])
	);
	button_debouncer bd_left (
		.clk(clk),
		.reset(rst_switch),
		.button_in(left_button),
		.button_out(direction[2])
	);
	button_debouncer bd_right (
		.clk(clk),
		.reset(rst_switch),
		.button_in(right_button),
		.button_out(direction[3])
	);
	*/



		// Instancia del módulo game2048
	game2048 game (
		.clk(clk),
		.rst(rst_switch),
		.num_max_win(num_max_win),
		.direction(direction),
		.board(board),
		.score(score),
		.game_state(game_state)
	);
	Controller_VGA controllerVGA(.clk(clk),.game_state(game_state),.matrix_table(board),.CLK_VGA(CLK_VGA),.SYNC_H(SYNC_H), .SYNC_V(SYNC_V), .SYNC_B(SYNC_B), .SYNC_BLANK(SYNC_BLANK),.Red(Red), .Green(Green), .Blue(Blue));
	
	bin_converter uut_converter(
        .bin(score),
        .bin_units(num_units),
        .bin_tens(num_tens),
		.bin_hundreds(num_hundreds),
		.bin_thousands(num_thousands),
		.bin_ten_thousands(num_ten_thousands),
		.bin_hundred_thousands(num_hundred_thousands)
	);

    // unit segments
	 bin_to_bcd_decoder uut_unit_d(
        .bin_number(num_units),
        .bcd_number(display_units)
    );

    // ten segments
    bin_to_bcd_decoder uut_ten_d(
        .bin_number(num_tens),
        .bcd_number(display_tens)
    );

	// hundred segments
	bin_to_bcd_decoder uut_hundred_d(
		.bin_number(num_hundreds),
		.bcd_number(display_hundreds)
	);

	// thousand segments
	bin_to_bcd_decoder uut_thousand_d(
		.bin_number(num_thousands),
		.bcd_number(display_thousands)
	);

	// ten thousand segments
	bin_to_bcd_decoder uut_ten_thousand_d(
		.bin_number(num_ten_thousands),
		.bcd_number(display_ten_thousands)
	);

	// hundred thousand segments
	bin_to_bcd_decoder uut_hundred_thousand_d(
		.bin_number(num_hundred_thousands),
		.bcd_number(display_hundred_thousands)
	);

	// 	button_debouncer bd_top (
	// 	.clk(clk),
	// 	.reset(rst_switch),
	// 	.button_in(top_button),
	// 	.button_out(direction[0])
	// );
	// button_debouncer bd_bottom (
	// 	.clk(clk),
	// 	.reset(rst_switch),
	// 	.button_in(bottom_button),
	// 	.button_out(direction[1])
	// );
	// button_debouncer bd_left (
	// 	.clk(clk),
	// 	.reset(rst_switch),
	// 	.button_in(left_button),
	// 	.button_out(direction[2])
	// );
	// button_debouncer bd_right (
	// 	.clk(clk),
	// 	.reset(rst_switch),
	// 	.button_in(right_button),
	// 	.button_out(direction[3])
	// );


	// Asignación de game_state y botones a game_state_leds
	assign game_state_leds = {~right_button, ~left_button, ~bottom_button, ~top_button, 1'b0,1'b0,1'b0,1'b0, game_state};

	// // Asignación de botones a direction
	assign direction = {~right_button, ~left_button, ~bottom_button,~ top_button};

endmodule
