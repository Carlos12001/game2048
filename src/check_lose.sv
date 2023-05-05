module check_lose (
    input logic [11:0] board_in [3:0][3:0],
    output logic result
);

  logic lose;
  logic row_move_possible, col_move_possible;
  logic row_check, col_check;

  // Verificar si hay movimientos posibles en la matriz
  always_comb begin
    lose = 1;
    for (int i = 0; i < 4; i++) begin
      row_move_possible = 0;
      col_move_possible = 0;
      for (int j = 0; j < 3; j++) begin
        row_check = (board_in[i][j] == board_in[i][j+1]) || (board_in[i][j] == 0) || (board_in[i][j+1] == 0);
        col_check = (board_in[j][i] == board_in[j+1][i]) || (board_in[j][i] == 0) || (board_in[j+1][i] == 0);

        row_move_possible |= row_check;
        col_move_possible |= col_check;
      end
      if (row_move_possible || col_move_possible) begin
        lose = 0;
      end
    end
  end

  assign result = lose;

endmodule
