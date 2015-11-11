library game_of_life.board;

import 'position.dart';
import 'dimensions.dart';

class Board {

  Set<Position> _cells = new Set();

  void addLiveCellAt(int x, int y) {
    _cells.add(new Position(x, y));
  }

  bool hasLiveCellAt(int x, int y) {
    return _cells.any((p) => p.equalsXY(x, y));
  }

  Board nextState() {
    Board nextBoard = new Board();

    _populateSurvivingCells(nextBoard);
    _populateArisingCells(nextBoard);

    return nextBoard;
  }

  // #### PRIVATE ####

  _populateSurvivingCells(Board targetBoard) {
    for (Position position in _cells) {
      int neighbourCount = _countLiveNeighboursAt(position);

      if (neighbourCount == 2 || neighbourCount == 3) {
        targetBoard.addLiveCellAt(position.x, position.y);
      }
    }
  }

  void _populateArisingCells(Board targetBoard) {
    _forEachDeadCell((Position p) {
      if (_countLiveNeighboursAt(p) == 3)
        targetBoard.addLiveCellAt(p.x, p.y);
    });
  }

  void _forEachDeadCell(PosFunc f) {
    Dimensions dimensions = _findBoardDimensions();
    dimensions.forEachPosition((Position p) {
      if (!hasLiveCellAt(p.x, p.y)) f(p);
    });
  }

  Dimensions _findBoardDimensions() {
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

    return new Dimensions(topLeft, bottomRight);
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
