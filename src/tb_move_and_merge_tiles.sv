`timescale 1ns / 1ps

module tb_move_and_merge_tiles;

  logic clk;
  logic [3:0] direction;
  logic [11:0] board_in[3:0][3:0];
  logic [11:0] board_out[3:0][3:0];
  logic [19:0] score_update;
  logic done;

  // Instantiate the design under test (DUT)
  move_and_merge_tiles dut (
    .direction(direction),
    .board_in(board_in),
    .board_out(board_out),
    .score_update(score_update),
    .done(done)
  );

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

  // Testbench stimulus
  initial begin
    // Initialize inputs
    clk = 0;
    direction = 4'b0000; 

    // Initialize board
    board_in[0][0] = 12'h002; board_in[0][1] = 12'h002; board_in[0][2] = 12'h004; board_in[0][3] = 12'h004;
    board_in[1][0] = 12'h002; board_in[1][1] = 12'h002; board_in[1][2] = 12'h004; board_in[1][3] = 12'h004;
    board_in[2][0] = 12'h000; board_in[2][1] = 12'h000; board_in[2][2] = 12'h004; board_in[2][3] = 12'h000;
    board_in[3][0] = 12'h008; board_in[3][1] = 12'h000; board_in[3][2] = 12'h004; board_in[3][3] = 12'h000;

    // Display results
    $display("Board before move:");
    display_board(board_in);

    if (done) begin 
      $display("Done_1");
    end

    #10;
    direction = 4'b0010;
    #10;
    direction = 4'b0000;
    if (done) begin 
      $display("Done_3"); 
    end
    // Display results
    $display("Board after bottom move:");
    display_board(board_out);
    board_in = board_out;

    #10;
    direction = 4'b0001;
    #10;
    direction = 4'b0000;
    if (done) begin 
      $display("Done_4"); 
    end
    // Display results
    $display("Board after top move:");
    display_board(board_out);
    board_in = board_out;


    #10;
    direction = 4'b0100;
    #10;
    direction = 4'b0000;
    if (done) begin 
      $display("Done_6"); 
    end
    // Display results
    $display("Board after left move:");
    display_board(board_out);
    board_in = board_out;


    #10;
    direction = 4'b1000;
    #10;
    direction = 4'b0000;
    if (done) begin 
      $display("Done_8"); 
    end
    // Display results
    $display("Board after right move:");
    display_board(board_out);
    board_in = board_out; 


    // Finish simulation
    $finish;
  end

endmodule
