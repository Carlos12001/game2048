`timescale 1ns / 1ps

module tb_place_random_four();
  logic clk;
  logic rst;
  logic start;
  logic [11:0] board_in[3:0][3:0];
  logic [11:0] board_out[3:0][3:0];
  logic done;

  place_random_four dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .board_in(board_in),
    .board_out(board_out),
    .done(done)
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
    start = 0;

    // Initialize board
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        board_in[i][j] = 0;
      end
    end

    // Test process
    #10;
    rst = 0;
    #10;
    $display("Initial board:");
    display_board(board_in);

    // Add first 4
    start = 1;
    #10;
    start = 0;
    @(posedge done);
    $display("Board after adding first 4:");
    display_board(board_out);
    board_in = board_out;
    #10
    start = 1;

    #10;
    start = 0;
    @(posedge done);
    #10; // Agrega un retardo adicional aquí
    $display("Board after adding second 4:");
    display_board(board_out);

    // Finish simulation
    $finish;
  end

endmodule
