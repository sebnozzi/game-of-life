library game_of_life.position;

typedef PosFunc(Position p);

class Position {

  int x;
  int y;

  Position(this.x, this.y) {
    assert(x != null);
    assert(y != null);
  }

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