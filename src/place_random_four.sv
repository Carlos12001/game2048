module place_random_four (
  input logic clk,
  input logic rst,
  input logic start,
  input logic [11:0] board_in[3:0][3:0],
  output logic [11:0] board_out[3:0][3:0],
  output logic done
);

  // LFSR para generar números pseudoaleatorios
  logic [3:0] lfsr;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      lfsr <= 4'b0001;
    end else begin
      lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[2]};
    end
  end

  // Estados
  typedef enum logic [1:0] {IDLE, SEARCH, FINISH} state_t;
  state_t current_state, next_state;

  // Variables temporales
  logic [11:0] local_board[3:0][3:0];
  integer row, col;

  // Logica de estado
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    local_board = board_in;
    row = lfsr[3:2];
    col = lfsr[1:0];
    done = 0;

    case (current_state)
      IDLE: begin
        if (start) begin
          next_state = SEARCH;
        end else begin
          next_state = IDLE;
        end
      end

      SEARCH: begin
        if (board_in[row][col] == 0) begin
          local_board[row][col] = 12'h004;
          next_state = FINISH;
        end else begin
          next_state = SEARCH;
        end
      end

      FINISH: begin
        done = 1;
        next_state = IDLE;
      end

      default: begin
        next_state = IDLE;
      end
    endcase
  end

  assign board_out = local_board;

endmodule
