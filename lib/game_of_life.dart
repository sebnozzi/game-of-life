library game_of_life;

import 'package:dart_range/dart_range.dart';

typedef PosFunc(Position p);

class Position {

  int x;
  int y;

  Position(this.x, this.y);

  bool equalsXY(int x, int y) {
    return this.x == x && this.y == y;
  }

  Position plus(Position other) {
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

  void addLiveCellAt(int x, int y) {
    _cells.add(new Position(x, y));
  }

  bool hasLiveCellAt(int x, int y) {
    return _cells.any((p) => p.equalsXY(x, y));
  }

  Board nextState() {
    Board nextBoard = new Board();

    _processLiveCells(nextBoard);
    _processDeadCells(nextBoard);

    return nextBoard;
  }

  void _processDeadCells(Board nextBoard) {
    _iterateOverDeadCells((Position p) {
      if (_countLiveNeighboursAt(p) == 3)
      nextBoard.addLiveCellAt(p.x, p.y);
    });
  }

  void _iterateOverDeadCells(PosFunc f) {
    BoardDimensions dimensions = _findBoardDimensions();
    dimensions.forEachPosition((Position p) {
      if (!hasLiveCellAt(p.x, p.y))
      f(p);
    });
  }

  BoardDimensions _findBoardDimensions() {
    int minX, minY, maxX, maxY = 0;

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


  _processLiveCells(Board nextBoard) {
    for (Position position in _cells) {
      int neighbourCount = _countLiveNeighboursAt(position);

      if (neighbourCount == 2 || neighbourCount == 3) {
        nextBoard.addLiveCellAt(position.x, position.y);
      }
    }
  }

  int _countLiveNeighboursAt(Position pos) {
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
      Position neighbourPos = pos.plus(offset);
      if (hasLiveCellAt(neighbourPos.x, neighbourPos.y)) {
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

  void forEachPosition(PosFunc f) {
    for (int y in rangeY()) {
      for (int x in rangeX()) {
        f(new Position(x, y));
      }
    }
  }

}



