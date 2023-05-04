`timescale 1ns / 1ps

module tb_game2048();
  logic clk;
  logic rst;
  logic [3:0] direction;
  logic [11:0] board[3:0][3:0];
  logic [19:0] score;
  logic [1:0] game_state;

  game2048 dut (
    .clk(clk),
    .rst(rst),
    .direction(direction),
    .board(board),
    .score(score),
    .game_state(game_state)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

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
    // Initialize signals
    clk = 0;
    #10;
    rst = 1;
    direction = 4'b0;

    // Test process
    #10;
    rst = 0;
    #50;
    $display("Initial board:");
    display_board(board);

    // Play some moves
    direction = 4'b1000; // right
    #10;
    $display("print R1: Board after move right:");
    display_board(board);

    direction = 4'b0000; // left
    #10;
    $display("print R2: Board after move right:");
    display_board(board);

    #10;
    $display("print R3: Board after move right:");
    display_board(board);

    #10;
    $display("print R4: Board after move right:");
    display_board(board);

    #10;
    $display("print R5: Board after move right:");
    display_board(board);

    // #10;
    // $display("Board after move left:");
    // display_board(board);

    // direction = 4'b0001; // top
    // #10;
    // $display("Board after move top:");
    // display_board(board);

    // direction = 4'b0010; // bottom
    // #10;
    // $display("Board after move bottom:");
    // display_board(board);

    // Finish simulation
    $finish;
  end

endmodule