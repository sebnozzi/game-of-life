library game_of_life.board_dimensions;

import 'position.dart';

import 'package:dart_range/dart_range.dart';

class BoardDimensions {

  Position topLeft;
  Position bottomRight;

  BoardDimensions(this.topLeft, this.bottomRight) {
    assert(topLeft != null);
    assert(bottomRight != null);
  }

  Range rangeX() => inclusiveIntRange(topLeft.x, bottomRight.x);

  Range rangeY() => inclusiveIntRange(topLeft.y, bottomRight.y);

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