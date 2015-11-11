library game_of_life.board;

import 'position.dart';
import 'board_dimensions.dart';

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
