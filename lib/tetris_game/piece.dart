import 'package:flutter/material.dart';
import 'package:game/tetris_game/tetris_page.dart';
import 'package:game/tetris_game/values.dart';

class Piece {
  // Type of Tetris piece
  Tetromino type;
  Piece({required this.type});

  // the piece is just a list of integers
  List<int> position = [];

  // Color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  // generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLeght;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // Rotate piece
  int rotationState = 1;
  void rotatePiece() {
    // new position
    List<int> newPosition = [];

    // rotate the piece based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          // Case 0
          case 0:
            // Get the new position
            newPosition = [
              position[1] - rowLeght,
              position[1],
              position[1] + rowLeght,
              position[1] + rowLeght + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // Case 1
          case 1:
            // Get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLeght - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 2
          case 2:
            // Get the new position
            newPosition = [
              position[1] + rowLeght,
              position[1],
              position[1] - rowLeght,
              position[1] - rowLeght - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 3
          case 3:
            // Get the new position
            newPosition = [
              position[1] - rowLeght + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      // J
      case Tetromino.J:
        switch (rotationState) {
          // Case 0
          case 0:
            // Get the new position
            newPosition = [
              position[1] - rowLeght,
              position[1],
              position[1] + rowLeght,
              position[1] + rowLeght - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // Case 1
          case 1:
            // Get the new position
            newPosition = [
              position[1] - rowLeght - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 2
          case 2:
            // Get the new position
            newPosition = [
              position[1] + rowLeght,
              position[1],
              position[1] - rowLeght,
              position[1] - rowLeght + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 3
          case 3:
            // Get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLeght + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      // I
      case Tetromino.I:
        switch (rotationState) {
          // Case 0
          case 0:
            // Get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // Case 1
          case 1:
            // Get the new position
            newPosition = [
              position[1] - rowLeght,
              position[1],
              position[1] + rowLeght,
              position[1] + 2 * rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 2
          case 2:
            // Get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 3
          case 3:
            // Get the new position
            newPosition = [
              position[1] + rowLeght,
              position[1],
              position[1] - rowLeght,
              position[1] - 2 * rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      // O
      case Tetromino.O:
        break;

      // S
      case Tetromino.S:
        switch (rotationState) {
          // Case 0
          case 0:
            // Get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLeght - 1,
              position[1] + rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // Case 1
          case 1:
            // Get the new position
            newPosition = [
              position[0] - rowLeght,
              position[0],
              position[0] + 1,
              position[0] + rowLeght + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 2
          case 2:
            // Get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLeght - 1,
              position[1] + rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 3
          case 3:
            // Get the new position
            newPosition = [
              position[0] - rowLeght,
              position[0],
              position[0] + 1,
              position[0] + rowLeght + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      // z
      case Tetromino.Z:
        switch (rotationState) {
          // Case 0
          case 0:
            // Get the new position
            newPosition = [
              position[0] + rowLeght - 2,
              position[1],
              position[2] + rowLeght - 1,
              position[3] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // Case 1
          case 1:
            // Get the new position
            newPosition = [
              position[0] - rowLeght + 2,
              position[1],
              position[2] - rowLeght + 1,
              position[3] - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 2
          case 2:
            // Get the new position
            newPosition = [
              position[0] + rowLeght - 2,
              position[1],
              position[2] + rowLeght - 1,
              position[3] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 3
          case 3:
            // Get the new position
            newPosition = [
              position[0] - rowLeght + 2,
              position[1],
              position[2] - rowLeght + 1,
              position[3] - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      // T
      case Tetromino.T:
        switch (rotationState) {
          // Case 0
          case 0:
            // Get the new position
            newPosition = [
              position[2] - rowLeght,
              position[2],
              position[2] + 1,
              position[2] + rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // Case 1
          case 1:
            // Get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 2
          case 2:
            // Get the new position
            newPosition = [
              position[1] - rowLeght,
              position[1] - 1,
              position[1],
              position[1] + rowLeght,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;

          // case 3
          case 3:
            // Get the new position
            newPosition = [
              position[2] - rowLeght,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation position
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  // check if valid position
  bool positionIsValid(int position) {
    // get the row and col of position
    int row = (position / rowLeght).floor();
    int col = position % rowLeght;

    // if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    // otherwise position is valid so return true
    else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstCol0ccupied = false;
    bool lastCol0ccupied = false;

    for (int pos in piecePosition) {
      // return false if any position is alredy taken
      if (!positionIsValid(pos)) {
        return false;
      }

      // get the coll position
      int col = pos % rowLeght;

      // check if the first or last column is occupied
      if (col == 0) {
        firstCol0ccupied = true;
      }
      if (col == rowLeght - 1) {
        lastCol0ccupied = true;
      }
    }

    // if there is a piece in the first col and last col, it is going through the wall
    return !(firstCol0ccupied && lastCol0ccupied);
  }
}
