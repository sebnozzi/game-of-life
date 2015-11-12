library game_of_life.board_dimensions;

import 'position.dart';

import 'package:dart_range/dart_range.dart';

class Dimensions {

  Position topLeft;
  Position bottomRight;

  Dimensions(this.topLeft, this.bottomRight) {
    assert(topLeft != null);
    assert(bottomRight != null);
  }

  Range get rangeX => inclusiveIntRange(topLeft.x, bottomRight.x);

  Range get rangeY => inclusiveIntRange(topLeft.y, bottomRight.y);

  @override
  String toString() => "Dimensions(topLeft: $topLeft, bottomRight: $bottomRight)";

  void forEachPosition(PosFunc f) {
    for (int y in rangeY) {
      for (int x in rangeX) {
        f(new Position(x, y));
      }
    }
  }

}