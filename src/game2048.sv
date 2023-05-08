/*
 2048 game module
 direction: 0001 top, 0010 bottom, 0100 left, 1000 right
 game_state: 00 not_playing, 01 playing, 10 win, 11 lose
*/
module game2048(
  input logic clk,
  input logic rst,
  input logic [11:0] num_max_win,
  input logic [3:0] direction,
  output logic [11:0] board[3:0][3:0],
  output logic [19:0] score, 
  output logic [1:0] game_state
);

	typedef enum logic [3:0] {START, FIRST_RANDOM_TILE, TRANSITION_SECOND_RANDOM, 
		SECOND_RANDOM_TILE, IDLE, 
		MOVE_MERGE, TRANSITION_NEW_RANDOM, NEW_TILE, CHECK_WIN,
		CHECK_LOSE, GAME_OVER} state_t;
	state_t current_state, next_state;

	logic [11:0] board_move[3:0][3:0];
	logic [11:0] board_random[3:0][3:0]; 
	logic [19:0] score_update;
	logic move_and_merge_done;
	logic place_random_start;
	logic place_random_done;
	logic check_win_result;
	logic check_lose_result;
	logic check_new_tile_result;

	move_and_merge_tiles move_and_merge (
	 .direction(direction),
	 .board_in(board),
	 .board_out(board_move),
	 .score_update(score_update),
	 .done(move_and_merge_done)
	);

	place_random_tiles place_random (
	 .clk(clk),
	 .rst(rst),
	 .start(place_random_start),
	 .board_in(board),
	 .board_out(board_random),
	 .done(place_random_done)
	);

	can_new_tile new_tile(
        .board_in(board),
        .result(check_new_tile_result)
    );

	check_win win (
		.num_max_win(num_max_win),
		.board_in(board),
		.result(check_win_result)
	);

	check_lose lose(
		.board_in(board),
		.result(check_lose_result)
	);

	always_ff @(posedge clk) begin
		if (rst) begin
			current_state <= START;
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin

	 case (current_state)
		START: begin
			for (int i = 0; i < 4; i++) begin
			    for (int j = 0; j < 4; j++) begin
				 board[i][j] = 0;
			 	end
			end
			score = 0;
			game_state = 0;
			place_random_start = 1;
			next_state = FIRST_RANDOM_TILE;
		end

		FIRST_RANDOM_TILE: begin
			place_random_start = 0;
			if (place_random_done) begin
				board = board_random;
				next_state = TRANSITION_SECOND_RANDOM;
		  end
		end

		TRANSITION_SECOND_RANDOM: begin
			place_random_start = 1;
			next_state = SECOND_RANDOM_TILE;
		end

		SECOND_RANDOM_TILE: begin
			place_random_start = 0;
			if (place_random_done) begin
				board = board_random;
				next_state = IDLE;
			end
		end

		IDLE: begin
			game_state = 2'b01; 
			if (direction != 4'b0) begin
			 next_state = MOVE_MERGE;
			end
		end

		MOVE_MERGE: begin
			game_state = 2'b00;
			if(move_and_merge_done) begin
				board = board_move;
				score = score + score_update; 
				next_state = TRANSITION_NEW_RANDOM;
				end
		end

		TRANSITION_NEW_RANDOM: begin
			if (check_new_tile_result) begin
				place_random_start = 1;
			end
			next_state = NEW_TILE;
		end

		NEW_TILE: begin
			place_random_start = 0;
			if (place_random_done) begin
				board = board_random;
				next_state = CHECK_WIN;
			end
		end

		CHECK_WIN: begin
			if (check_win_result) begin
				game_state = 2'b10; // win
				next_state = GAME_OVER;
			end else begin
				next_state = CHECK_LOSE;
			end
		end

		CHECK_LOSE: begin
			if (check_lose_result) begin
				game_state = 2'b11; // lose
				next_state = GAME_OVER;
			end else begin
			 next_state = IDLE;
			end
		end

		GAME_OVER: begin
		end

		default: begin
		  next_state = START;
		end
	 endcase
	end
endmodule
