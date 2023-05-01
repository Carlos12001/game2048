`timescale 1ns / 1ps

module tb_place_random_four;

  reg clk;
  reg rst;
  reg start;
  reg [11:0] board_in[3:0][3:0];
  wire [11:0] board_out[3:0][3:0];
  wire done;

  place_random_four place_random_four_inst (
    .clk(clk),
    .rst(rst),
    .start(start),
    .board_in(board_in),
    .board_out(board_out),
    .done(done)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  integer i, j;

  initial begin
    reg [11:0] temp_board[4][4];
    rst = 1;
    start = 0;

    // Llena la matriz
    temp_board = '{
      '{12'h008, 12'h008, 12'h008, 12'h000},
      '{12'h008, 12'h008, 12'h008, 12'h000},
      '{12'h008, 12'h008, 12'h008, 12'h000},
      '{12'h008, 12'h008, 12'h008, 12'h000}
    };

    for (i = 0; i < 4; i++) begin
      for (j = 0; j < 4; j++) begin
        board_in[i][j] <= temp_board[i][j];
      end
    end

    @(posedge clk) rst <= 0;
    @(posedge clk) start <= 1;
    @(posedge clk) start <= 0;

    // Espera a que se coloque el 4 en una posición aleatoria
    wait(done);

    // Imprime la matriz de entrada
    $display("Initial board:");
    for (i = 0; i < 4; i++) begin
      for (j = 0; j < 4; j++) begin
        $write("%4d ", board_in[i][j]);
      end
      $display("");
    end

    // Imprime la matriz de salida
    $display("Board after placing random 4:");
    for (i = 0; i < 4; i++) begin
      for (j = 0; j < 4; j++) begin
        $write("%4d ", board_out[i][j]);
      end
      $display("");
    end

    $finish;
  end

endmodule
