module tb_move_and_merge_tiles;

  logic [3:0] direction;
  logic [11:0] board_in[0:15];
  logic [11:0] board_out[0:15];
  logic [19:0] score_update;
  
  move_and_merge_tiles dut (
    .direction(direction),
    .board_in(board_in),
    .board_out(board_out),
    .score_update(score_update)
  );

  initial begin
    // Initialize the board
    board_in = '{2, 2, 4, 4,
                 2, 2, 4, 4,
                 0, 0, 0, 0,
                 0, 0, 0, 0};
    
    // Perform top move
    direction = 4'b0001;
    #10; // Wait for some time

    // Print the board after top move
    $display("After top move:");
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        $write("%4d ", board_out[4 * i + j]);
      end
      $display("");
    end
    $display("Score update: %d", score_update);

    // Perform other moves (bottom, left, right) and print the board similarly
    
    $finish;
  end

endmodule
