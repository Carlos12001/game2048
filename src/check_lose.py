def check_lose(board_in):
    lose = True

    for i in range(4):
        row_move_possible = False
        col_move_possible = False
        for j in range(3):
            row_check = (board_in[i][j] == board_in[i][j + 1]) or (board_in[i][j] == 0) or (board_in[i][j + 1] == 0)
            col_check = (board_in[j][i] == board_in[j + 1][i]) or (board_in[j][i] == 0) or (board_in[j + 1][i] == 0)

            row_move_possible |= row_check
            col_move_possible |= col_check

        if row_move_possible or col_move_possible:
            lose = False

    return lose


# Ejemplo de uso
board_in = [[4, 16, 8, 8],
            [8, 128, 64, 4],
            [4, 32, 8, 16],
            [2, 4, 16, 8]]

result = check_lose(board_in)
print("Perdió" if result else "No perdió")
