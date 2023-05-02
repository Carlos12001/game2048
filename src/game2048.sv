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

  // typedef enum logic [2:0] {START, SECOND_RANDOM_TILE, IDLE, 
  // MOVE_MERGE, NEW_TILE, CHECK_WIN, CHECK_TIE, GAME_OVER} state_t;
  // state_t current_state, next_state;

  // logic [11:0] board_move[3:0][3:0];
  // logic [11:0] board_random[3:0][3:0]; 
  // logic [19:0] score_update;
  // logic move_and_merge_done;
  // logic place_random_done;
  // logic check_win_done;
  // logic check_tie_done;


  // move_and_merge_tiles move_and_merge (
  //   .direction(direction),
  //   .board_in(board),
  //   .board_out(board_move),
  //   .score_update(score_update)
  //   // .done(place_random_done)
  // );

  // place_random_four place_random (
  //   .clk(clk),
  //   .rst(rst),
  //   .start(move_and_merge_done),
  //   .board_in(board),
  //   .board_out(board_random),
  //   .done(place_random_done)
  // );

  // always_ff @(posedge clk) begin
  //   if (rst) begin
  //     game_state = 2'b00; // playing
  //     current_state <= START;
  //   end else begin
  //     current_state <= next_state;
  //   end
  // end

  // always_comb begin
  //   move_and_merge_done = 1'b0;
  //   place_random_done = 1'b0;
  //   check_win_done = 1'b0;
  //   check_tie_done = 1'b0;
  //   next_state = current_state;

  //   case (current_state)
  //     START: begin
  //       // initaliza la board con dos numros 4 en posiciones aleatorias
  //       score = 20'b0;
  //       // No avanza hasta el siguiente estado si hasta que termine de colocar los 4
  //       if (place_random_done) begin 
  //         board = board_random;
  //         game_state = 2'b01; 
  //         next_state = SECOND_RANDOM_TILE;
  //       end
  //     end

  //     IDLE: begin
  //       // No avanza hasta que se reciba un nuevo movimiento
  //       if (direction != 4'b0) begin
  //         game_state = 2'b01; 
  //         next_state = MOVE_MERGE;
  //       end
  //     end

  //     MOVE_MERGE: begin
  //       // No avanza con el siguiente estado hasta termina de hacer los movimientos
  //       if(move_and_merge_done) begin
  //         board = board_move;
  //         score = score + score_update;
  //         next_state = NEW_TILE;
  //       end
  //     end

  //     NEW_TILE: begin
  //       // No avanza con el siguiente estado hasta termina de pone el numero 
  //       if (place_random_done) begin
  //         board = board_random;
  //         next_state = CHECK_WIN;
  //       end
  //     end

  //     GAME_OVER: begin
  //     end

  //     default: begin
  //       next_state = START;
  //     end
  //   endcase
  // end
endmodule