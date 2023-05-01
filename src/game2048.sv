/*
 2048 game module
 direction: 00 top, 01 bottom, 10 left, 11 right
 game_state: 00 not_playing, 01 playing, 10 win, 11 lose
*/

module game2048 #(parameter WIDTH = 11)(
  input logic clk,
  input logic rst,
  input logic [3:0] direction,
  output logic  [11:0] board[3:0][3:0],
  output logic [19:0] score, 
  output logic [1:0] game_state
  );

  // typedef enum logic [2:0] {START, IDLE, MOVE_MERGE, NEW_TILE, CHECK_END} state_t;
  // state_t current_state, next_state;
  // logic [3:0][3:0] reg_board_matrix;
  // logic [15:0] reg_score;

  // move_and_merge_tiles move_and_merge_tiles_inst (
  //   .direction(direction),
  //   .board(reg_board_matrix),
  //   .score(reg_score) // Conectar score_update a reg_score_update
  // );

  // //actual state logic
  // always_ff @(posedge clk or posedge rst) begin
  //   if (rst) begin
  //     current_state <= START;
  //   end else begin
  //     current_state <= next_state;
  //   end
  // end

  // always_comb begin
  //   next_state = current_state;
  //   score = reg_score;

  //   case (current_state)
  //     START: begin
  //       // Inicializar el tablero y el puntaje
  //       reg_board_matrix = '0;
  //       reg_score = 0;
  //       next_state = IDLE;
  //     end

  //     IDLE: begin
  //       if (/* Condición para empezar a mover */) begin
  //         next_state = MOVE_MERGE;
  //       end
  //     end

  //     MOVE_MERGE: begin
  //       // Fusionar las baldosas en función de la dirección
  //       next_state = NEW_TILE;
  //     end

  //     NEW_TILE: begin
  //       // Generar una nueva baldosa
  //       next_state = CHECK_END;
  //     end

  //     CHECK_END: begin
  //       if (/* Condición de victoria */) begin
  //         // Ganaste, reiniciar el juego
  //         next_state = START;
  //         game_state = 2'b10; // Indicar estado de victoria
  //       end else if (/* Condición de derrota */) begin
  //         // Perdiste, reiniciar el kjuego
  //         next_state = START;
  //         game_state = 2'b11; // Indicar estado de derrota
  //       end else begin
  //         next_state = IDLE;
  //         game_state = 2'b01; // Indicar estado de juego en curso
  //       end
  //     end
  //   endcase
  // end

endmodule
