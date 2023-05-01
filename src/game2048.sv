/*
 2048 game module
 direction: 0001 top, 0010 bottom, 0100 left, 1000 right
 game_state: 00 not_playing, 01 playing, 10 win, 11 lose
*/

module game2048 (
  input logic clk,
  input logic rst,
  input logic [3:0] direction,
  output logic [11:0] board[3:0][3:0],
  output logic [19:0] score, 
  output logic [1:0] game_state
);

  // typedef enum logic [2:0] {START, IDLE, MOVE_MERGE, NEW_TILE, CHECK_END, GAME_OVER} state_t;
  // state_t current_state, next_state;

  // logic [11:0] board_temp[3:0][3:0];
  // logic [19:0] score_update;
  // logic move_and_merge_done;
  // logic place_random_done;

  // move_and_merge_tiles move_and_merge (
  //   .direction(direction),
  //   .board_in(board),
  //   .board_out(board_temp),
  //   .score_update(score_update)
  // );

  // always_ff @(posedge clk) begin
  //   if (rst) begin
  //     current_state <= START;
  //   end else begin
  //     current_state <= next_state;
  //   end
  // end

  // always_comb begin
  //   game_state = 2'b01; // playing
  //   move_and_merge_done = 1'b0;
  //   place_random_done = 1'b0;
  //   next_state = current_state;

  //   case (current_state)
  //     START: begin
  //       // Initialize board and score
  //       for (integer i = 0; i < 4; i++) begin
  //         for (integer j = 0; j < 4; j++) begin
  //           board[i][j] = 12'b0;
  //         end
  //       end
  //       score = 20'b0;
  //       next_state = IDLE;
  //     end

  //     IDLE: begin
  //       if (direction != 4'b0) begin
  //         next_state = MOVE_MERGE;
  //       end
  //     end

  //     MOVE_MERGE: begin
  //       move_and_merge_done = 1'b1;
  //       board = board_temp;
  //       score = score + score_update;
  //       next_state = NEW_TILE;
  //     end

  //     NEW_TILE: begin
  //       place_random_done = 1'b1;
  //       board = board_temp;
  //       next_state = CHECK_END;
  //     end

  //     CHECK_END: begin
  //       // Check for win or lose
  //       // Update game_state accordingly
  //       // If game continues, go to IDLE, otherwise go to GAME_OVER
  //       if (/* win condition */) begin
  //         game_state = 2'b10; // win
  //         next_state = GAME_OVER;
  //       end else if (/* lose condition */) begin
  //         game_state = 2'b11; // lose
  //         next_state = GAME_OVER;
  //       end else begin
  //         next_state = IDLE;
  //       end
  //     end

  //     GAME_OVER: begin
  //       // Stay in this state until reset
  //     end

  //     default: begin
  //       next_state = IDLE;
  //     end
  //   endcase
  // end

endmodule
