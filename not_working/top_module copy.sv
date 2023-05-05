module top_module (
	input logic clk,
	input logic rst_switch,
	input logic top_button,
	input logic bottom_button,
	input logic left_button,
	input logic right_button,
	input logic [8:0] num_max_win_switches,
	output logic [3:0] game_state_leds
);

	// Variables internas
	logic [11:0] num_max_win;
	logic [3:0] direction;
	logic [11:0] board[3:0][3:0];
	logic [19:0] score;
	logic [1:0] game_state;

	// Conectar num_max_win a num_max_win_switches
	always_ff @(posedge clk) begin
		num_max_win[11] <= num_max_win_switches[8];
		num_max_win[10] <= num_max_win_switches[7];
		num_max_win[9] <= num_max_win_switches[6];
		num_max_win[8] <= num_max_win_switches[5];
		num_max_win[7] <= num_max_win_switches[4];
		num_max_win[6] <= num_max_win_switches[3];
		num_max_win[5] <= num_max_win_switches[2];
		num_max_win[4] <= num_max_win_switches[1];
		num_max_win[3] <= num_max_win_switches[0];
		num_max_win[2] <= 0;
		num_max_win[1] <= 0;
		num_max_win[0] <= 0;
	end

	// Conectar la dirección a los botones de entrada
	always_ff @(posedge clk) begin
		if (top_button) direction <= 4'b0001;
		else if (bottom_button) direction <= 4'b0010;
		else if (left_button) direction <= 4'b0100;
		else if (right_button) direction <= 4'b1000;
		else direction <= 4'b0000;
	end

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


	// Conectar game_state a game_state_leds
	assign game_state_leds = game_state;

endmodule
