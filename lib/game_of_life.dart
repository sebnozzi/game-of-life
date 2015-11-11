// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The game_of_life library.
library game_of_life;

class Position {

  int x;
  int y;

  Position(this.x, this.y) {
  }

  bool isAt(int x, int y) {
    return this.x == x && this.y == y;
  }

  Position add(Position other) {
    return new Position(this.x + other.x, this.y + other.y);
  }

}

class Board {

  Set<Position> _cells = new Set();

  bool isEmpty() => true;

  Board nextState() {
    Board nextBoard = new Board();

    // iterate over cells
    // count neighbours for each cell
    // if it has 2, then it lives on

    for(Position position in _cells.toList()) {
      int neighbourCount = _countNeighboursAt(position);
      if(neighbourCount == 2) {
        nextBoard.addCellAt(position.x, position.y);
      }
    }

    return nextBoard;
  }

  void addCellAt(int x, int y) {
    _cells.add(new Position(x, y));
  }

  bool hasCellAt(int x, int y) {
    return _cells.any((p) => p.isAt(x, y));
  }

  int _countNeighboursAt(Position pos) {
    List<Position> neighbourOffsets = [
      new Position(-1, -1),
      new Position(0, -1),
      new Position(1, -1),
      new Position(-1, 0),
      new Position(1, 0),
      new Position(-1, 1),
      new Position(0, 1),
      new Position(1, 1)
    ];
    int count = 0;
    for(Position offset in neighbourOffsets){
      Position neighbourPos = pos.add(offset);
      if(hasCellAt(neighbourPos.x, neighbourPos.y)) {
        count++;
      }
    }
    return count;
  }

}



