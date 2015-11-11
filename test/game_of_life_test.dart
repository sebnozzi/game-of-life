
library game_of_life.test;

import 'package:game_of_life/game_of_life.dart';
import 'package:test/test.dart';

void main() {

  group('Querying for "live" cell status:', () {
    Board boardWithCellAt_2_2() =>
      new Board()
        ..addLiveCellAt(2, 2);

    test('should find "live" cell after adding', () {
      expect(boardWithCellAt_2_2().hasLiveCellAt(2, 2), isTrue);
    });

    test('should NOT find "live" cell if added elsewhere', () {
      expect(boardWithCellAt_2_2().hasLiveCellAt(3, 5), isFalse);
    });
  });

  group('Rule 1. Any live cell with fewer than two live neighbours dies:', () {

    test('Cell without neighbours', () {
      var board = new Board();
      board.addLiveCellAt(2, 2);
      var nextBoard = board.nextState();
      expect(nextBoard.hasLiveCellAt(2, 2), isFalse);
    });

    test('Only one neighbour', () {
      var board = new Board();
      board.addLiveCellAt(2, 2);
      board.addLiveCellAt(3, 2);

      var nextBoard = board.nextState();

      expect(nextBoard.hasLiveCellAt(2, 2), isFalse);
      expect(nextBoard.hasLiveCellAt(3, 2), isFalse);
    });

  }); // Rule 1

  group('Rule 2. Any live cell with more than three live neighbours dies:', () {

    test('Cell with four neighbours', () {
      var board = new Board();
      board.addLiveCellAt(2, 2);
      // Neighbours:
      board.addLiveCellAt(3, 2);
      board.addLiveCellAt(1, 2);
      board.addLiveCellAt(2, 1);
      board.addLiveCellAt(2, 3);

      var nextBoard = board.nextState();

      expect(nextBoard.hasLiveCellAt(2, 2), isFalse);
    });

  }); // Rule 2

  group('Rule 3. Any cell with two or three neighbours lives on:', () {

    test('Cell with TWO neighbours', () {
      var board = new Board();
      board.addLiveCellAt(2, 2);
      // Neighbours:
      board.addLiveCellAt(3, 2);
      board.addLiveCellAt(1, 2);

      var nextBoard = board.nextState();

      expect(nextBoard.hasLiveCellAt(2, 2), isTrue);
    });

    test('Cell with THREE neighbours', () {
      var board = new Board();
      board.addLiveCellAt(2, 2);
      // Neighbours:
      board.addLiveCellAt(3, 2);
      board.addLiveCellAt(1, 2);
      board.addLiveCellAt(2, 1);

      var nextBoard = board.nextState();

      expect(nextBoard.hasLiveCellAt(2, 2), isTrue);
    });

  }); // Rule 3

  test('Rule 4. Any dead cell with exactly three live neighbours becomes a live cell.', () {
    var board = new Board();
    // Neighbours of "dead/absent" (2,2):
    board.addLiveCellAt(3, 2);
    board.addLiveCellAt(1, 2);
    board.addLiveCellAt(2, 1);

    var nextBoard = board.nextState();

    expect(nextBoard.hasLiveCellAt(2, 2), isTrue);
  });


}
