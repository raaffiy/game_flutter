import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/tetris_game/piece.dart';
import 'package:game/tetris_game/pixel.dart';
import 'package:game/tetris_game/values.dart';

// Create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLeght,
  (i) => List.generate(
    rowLeght,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // current Score
  int currentScore = 0;

  // game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  // game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          // clear lines
          clearLines();

          // check landing
          checkLanding();

          // check if game is over
          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }

          // Move Current piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // Game Over Message
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text("Your Score is: $currentScore"),
        actions: [
          TextButton(
              onPressed: () {
                // Reset The game
                resetGame();
                Navigator.pop(context);
              },
              child: const Text('Play Again'))
        ],
      ),
    );
  }

  // Reset Game
  void resetGame() {
    // clear the game board
    gameBoard = List.generate(
      colLeght,
      (i) => List.generate(
        rowLeght,
        (j) => null,
      ),
    );

    // new game
    gameOver = false;
    currentScore = 0;

    // create new piece
    createNewPiece();

    // start the game
    startGame();
  }

  // check for collision in a future position
  // return true -> there is a collision
  // return false -> there is no collision
  bool checkCollision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row and column of the current position
      int row = (currentPiece.position[i] / rowLeght).floor();
      int col = currentPiece.position[i] % rowLeght;

      // adjust the row and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the piece is out of bounds (either too low or too far to the left or right)
      if (row >= colLeght || col < 0 || col >= rowLeght) {
        return true;
      }
      // check if the position is already occupied by another piece
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }

    // if no collision are detected, return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      // mark position as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLeght).floor();
        int col = currentPiece.position[i] % rowLeght;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();

      // check if the new piece collides immediately after creation
      if (checkCollision(Direction.down)) {
        // if collision occurs, it means the game is over
        gameOver = true;
      }
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();

    // create a new with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    /*

      Since our game over condition is if there is a piece at the top level, 
      you want to check if the game is over when you create a new piece 
      instead of checking every frame, because new pieces are allowed to go 
      through the top level but if there is already a piece in the top level 
      when the new piece is created, then game is over

    */
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // Move left
  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // Move Right
  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // Move Rotate Piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    // Stepp 1 : Loop through each row of the game board from bottom to top
    for (int row = colLeght - 1; row >= 0; row--) {
      // Step 2 : Initialize a variabel to track if the row is null
      bool rowIsFull = true;
      // Step 3 : check if the row if full (all columns in the row are filled with pieces)
      for (int col = 0; col < rowLeght; col++) {
        // if there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step 4 : if the row is full, clear the row and shift rows down
      if (rowIsFull) {
        // Step 5 : move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        // step 6 : set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);
        // step 7 : Increase the score!
        currentScore++;
      }
    }
  }

  // Game Over Method
  bool isGameOver() {
    // check if any columns in the top row are filled
    for (int col = 0; col < rowLeght; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    // if the top row is empty, the game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Game
          Expanded(
            child: GridView.builder(
              itemCount: rowLeght * colLeght,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLeght),
              itemBuilder: (context, index) {
                // get row and cool of each index
                int row = (index / rowLeght).floor();
                int col = index % rowLeght;

                // current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                  );
                }

                // landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(color: tetrominoColors[tetrominoType]);
                }

                // blank pixel
                else {
                  return Pixel(
                    color: Colors.grey,
                  );
                }
              },
            ),
          ),

          // Score
          Text(
            'Score: $currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          // Game Controls
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                ),

                // Rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right),
                ),

                // Right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
