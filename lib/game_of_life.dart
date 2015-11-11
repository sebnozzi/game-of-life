// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The game_of_life library.
library game_of_life;

import 'package:dart_range/dart_range.dart';

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

  @override
  String toString() {
    return "Pos(x: $x, y: $y)";
  }

}

class Board {

  Set<Position> _cells = new Set();

  bool isEmpty() => true;


  Board nextState() {
    Board nextBoard = new Board();

    _processLiveCells(nextBoard);
    _processDeadCells(nextBoard);

    return nextBoard;
  }

  void _processDeadCells(Board nextBoard) {
    // the problem is... where does our board start, where does it end?
    // we need to find max-x, max-y, and assume (0,0) as a starting point
    BoardDimensions dimensions = _findBoardDimensions();

    // iterate over dead cells within our dimensions
    for(int y in dimensions.rangeY()){
      for(int x in dimensions.rangeX()) {
        if(!hasCellAt(x,y)){
          int count = _countNeighboursAt(new Position(x,y));
          if(count == 3){
            nextBoard.addCellAt(x,y);
          }
        }
      }
    }
  }

  BoardDimensions _findBoardDimensions() {
    int minX = 0;
    int minY = 0;
    int maxX = 0;
    int maxY = 0;

    for (Position position in _cells) {
      if (position.x > maxX) maxX = position.x;
      if (position.y > maxY) maxY = position.y;
      if (position.x < minX) minX = position.x;
      if (position.y < minY) minY = position.y;
    }

    Position topLeft = new Position(minX, minY);
    Position bottomRight = new Position(maxX, maxY);

    return new BoardDimensions(topLeft, bottomRight);
  }

  void addCellAt(int x, int y) {
    _cells.add(new Position(x, y));
  }

  bool hasCellAt(int x, int y) {
    return _cells.any((p) => p.isAt(x, y));
  }

  _processLiveCells(Board nextBoard) {
    for (Position position in _cells) {
      int neighbourCount = _countNeighboursAt(position);

      if (neighbourCount == 2 || neighbourCount == 3) {
        nextBoard.addCellAt(position.x, position.y);
      }
    }
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
    for (Position offset in neighbourOffsets) {
      Position neighbourPos = pos.add(offset);
      if (hasCellAt(neighbourPos.x, neighbourPos.y)) {
        count++;
      }
    }
    return count;
  }

}

class BoardDimensions {

  Position topLeft;
  Position bottomRight;

  BoardDimensions(this.topLeft, this.bottomRight);

  Range rangeY() => inclusiveIntRange(topLeft.y, bottomRight.y);
  Range rangeX() => inclusiveIntRange(topLeft.x, bottomRight.x);

  @override
  String toString() {
    return "BoardDimensions(topLeft: $topLeft, bottomRight: $bottomRight)";
  }


}



