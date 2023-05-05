module tb_check_lose;
  logic [11:0] board_in [3:0][3:0];
  logic result;

  check_lose check_lose_inst(
    .board_in(board_in),
    .result(result)
  );
    // Display board
  task display_board;
    input logic [11:0] board[3:0][3:0];
    begin
      for (int i = 0; i < 4; i++) begin
        for (int j = 0; j < 4; j++) begin
          $write("%4d \t", board[i][j]);
        end
        $display("\n");
      end
      $display("\n");
    end
  endtask

  initial begin
    // Caso donde hay movimientos posibles
    board_in = '{
            '{4, 16, 8, 8},
            '{8, 128, 64, 4},
            '{4, 32, 8, 16},
            '{2, 4, 16, 8}
    };
    #10;
    display_board(board_in);
    assert (result === 0) else $error("Error: Movimientos posibles no detectados");

    // Caso donde no hay movimientos posibles
    board_in = '{
            '{4, 16, 8, 2},
            '{8, 128, 64, 4},
            '{4, 32, 8, 16},
            '{2, 4, 16, 8}
    };
    #10;
    display_board(board_in);
    assert (result === 1) else $error("Error: Movimientos imposibles no detectados");

    $display("Testbench finalizado con éxito");
    $finish;
  end
endmodule
