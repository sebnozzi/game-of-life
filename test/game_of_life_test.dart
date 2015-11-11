// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library game_of_life.test;

import 'package:game_of_life/game_of_life.dart';
import 'package:test/test.dart';

Board makeEmptyBoard() {
  var board = new Board();
  return board;
}

Board makeBoardWithCellAt_2_2() {
  Board board = new Board();
  board.addCellAt(2, 2);
  return board;
}

void main() {


  group('initially', () {

    test('a board is empty', () {
      var board = makeEmptyBoard();
      expect(board.isEmpty(), isTrue);
    });

  });

  test('a board can add live cells', () {
    Board board = new Board();
    board.addCellAt(2, 2);
  });

  group('asking for cells:', () {
    test('should find present cell', () {
      Board board = makeBoardWithCellAt_2_2();
      expect(board.hasCellAt(2, 2), isTrue);
    });
    test('should NOT find absent cell', () {
      Board board = makeBoardWithCellAt_2_2();
      expect(board.hasCellAt(3, 5), isFalse);
    });
  });

  group('next-state', () {

    test('of an empty board is an empty board', () {
      var board = makeEmptyBoard();
      var nextBoard = board.nextState();
      expect(nextBoard.isEmpty(), isTrue);
    });

    test('of a board with one cell is an empty board (rule 1)', () {
      var board = makeBoardWithCellAt_2_2();
      var nextBoard = board.nextState();
      expect(nextBoard.isEmpty(), isTrue);
    });

  });

  /*
  *  Rules:
  *
  *  1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  *  2. Any live cell with more than three live neighbours dies, as if by overcrowding.
  *  3. Any live cell with two or three live neighbours lives on to the next generation.
  *  4. Any dead cell with exactly three live neighbours becomes a live cell.
  *
  * */
  group('Rule', () {

    group('1. Any live cell with fewer than two live neighbours dies:', () {

      test('Lone cell', () {
        var board = new Board();
        board.addCellAt(2, 2);
        var nextBoard = board.nextState();
        expect(nextBoard.hasCellAt(2, 2), isFalse);
      });

      test('Only one neighbour', () {
        var board = new Board();
        board.addCellAt(2, 2);
        board.addCellAt(3, 2);

        var nextBoard = board.nextState();

        expect(nextBoard.hasCellAt(2, 2), isFalse);
        expect(nextBoard.hasCellAt(3, 2), isFalse);
      });

    });

    group('2. Any live cell with more than three live neighbours dies:', () {

      test('Cell with four neighbours', () {
        var board = new Board();
        board.addCellAt(2, 2);
        // Neighbours:
        board.addCellAt(3, 2);
        board.addCellAt(1, 2);
        board.addCellAt(2, 1);
        board.addCellAt(2, 3);

        var nextBoard = board.nextState();

        expect(nextBoard.hasCellAt(2, 2), isFalse);
      });

    });

    group('3. Any cell with two or three neighbours lives on:', () {

      test('Cell with TWO neighbours', () {
        var board = new Board();
        board.addCellAt(2, 2);
        // Neighbours:
        board.addCellAt(3, 2);
        board.addCellAt(1, 2);

        var nextBoard = board.nextState();

        expect(nextBoard.hasCellAt(2, 2), isTrue);
      });

      test('Cell with THREE neighbours', () {
        var board = new Board();
        board.addCellAt(2, 2);
        // Neighbours:
        board.addCellAt(3, 2);
        board.addCellAt(1, 2);
        board.addCellAt(2, 1);

        var nextBoard = board.nextState();

        expect(nextBoard.hasCellAt(2, 2), isTrue);
      });

    });

    test('4. Any dead cell with exactly three live neighbours becomes a live cell.', () {

      var board = new Board();
      // Neighbours of empty (2,2):
      board.addCellAt(3, 2);
      board.addCellAt(1, 2);
      board.addCellAt(2, 1);

      var nextBoard = board.nextState();

      expect(nextBoard.hasCellAt(2, 2), isTrue);

    });


  });

}
