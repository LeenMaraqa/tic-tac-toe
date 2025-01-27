import 'dart:io';

class TicTacToeGame {
  // The game board, initialized with 9 empty spaces
  List<String> gameBoard = List.filled(9, ' ');
  String currentPlayer = 'X';

  // Start the game
  void startGame() {
    while (true) {
      displayBoard();  // Display the current game board
      playerMove();    // Prompt the current player to make a move
      if (checkForWinner()) {  // Check if the current player has won
        displayBoard();
        print('Player $currentPlayer wins!');
        restartGame();  // Restart the game after a win
        break;
      } else if (checkForDraw()) {  // Check if the game is a draw
        displayBoard();
        print("It's a draw!");
        restartGame();  // Restart the game after a draw
        break;
      }
      switchPlayer();  // Switch to the other player
    }
  }

  // Display the current state of the game board
  void displayBoard() {
    print('\n ${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]} ');
    print('---+---+---');
    print(' ${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]} ');
    print('---+---+---');
    print(' ${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]} ');
  }

  // Prompt the current player to make a move
  void playerMove() {
    int move;
    bool validMove = false;

    while (!validMove) {
      stdout.write('Player $currentPlayer, enter your move (1-9): ');
      String? input = stdin.readLineSync();
      if (input != null && int.tryParse(input) != null) {
        move = int.parse(input);
        if (move >= 1 && move <= 9 && gameBoard[move - 1] == ' ') {
          gameBoard[move - 1] = currentPlayer;  // Mark the board with the player's symbol
          validMove = true;
        } else {
          print('Invalid move! The cell is already taken or out of range. Try again.');
        }
      } else {
        print('Invalid input! Please enter a number between 1 and 9.');
      }
    }
  }

  // Check if the current player has won
  bool checkForWinner() {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Columns
      [0, 4, 8], [2, 4, 6]  // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (gameBoard[pattern[0]] == currentPlayer &&
          gameBoard[pattern[1]] == currentPlayer &&
          gameBoard[pattern[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  // Check if the game ended in a draw
  bool checkForDraw() {
    return !gameBoard.contains(' ');  // If there are no empty spaces left, it's a draw
  }

  // Switch the current player from 'X' to 'O' or vice versa
  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  // Restart the game after a win or a draw
  void restartGame() {
    stdout.write('Do you want to play again? (y/n): ');
    String? response = stdin.readLineSync();
    if (response?.toLowerCase() == 'y') {
      gameBoard = List.filled(9, ' ');  // Reset the game board
      currentPlayer = 'X';  // Reset the starting player to 'X'
      startGame();  // Start the game again
    } else {
      print('Thanks for playing!');
      exit(0);  // Exit the game
    }
  }
}

void main() {
  TicTacToeGame game = TicTacToeGame();
  game.startGame();  // Start the game
}
