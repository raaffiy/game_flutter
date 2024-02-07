bool isWhite(int index) {
  // background color chess
  int x = index ~/ 8;
  int y = index % 8;
  bool isWhite = (x + y) % 2 == 0;
  return isWhite;
}

bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 8;
}
