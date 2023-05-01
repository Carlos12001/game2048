`timescale 1ns / 1ps

module tb_move_and_merge_tiles;

  logic [3:0] direction;
  logic [11:0] board_in[3:0][3:0];
  logic [11:0] board_out[3:0][3:0];
  logic [19:0] score_update;

  // Instantiate the design under test (DUT)
  move_and_merge_tiles dut (
    .direction(direction),
    .board_in(board_in),
    .board_out(board_out),
    .score_update(score_update)
  );

  // Clock generation
  logic clk;
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    // Initialize inputs
    clk = 0;
    direction = 4'b0001; // Move up

    // Initialize board
    board_in[0][0] = 12'h002; board_in[0][1] = 12'h002; board_in[0][2] = 12'h004; board_in[0][3] = 12'h004;
    board_in[1][0] = 12'h002; board_in[1][1] = 12'h002; board_in[1][2] = 12'h004; board_in[1][3] = 12'h004;
    board_in[2][0] = 12'h000; board_in[2][1] = 12'h000; board_in[2][2] = 12'h004; board_in[2][3] = 12'h000;
    board_in[3][0] = 12'h000; board_in[3][1] = 12'h000; board_in[3][2] = 12'h003; board_in[3][3] = 12'h000;

    // Apply stimulus and wait for results
    #10;

    // Display results
    $display("Board after move:");
    for (integer i = 0; i < 4; i++) begin
      $display("%h %h %h %h", board_out[i][0], board_out[i][1], board_out[i][2], board_out[i][3]);
    end
    $display("Score update: %h", score_update);

    // Finish simulation
    $finish;
  end

endmodule
