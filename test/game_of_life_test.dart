// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library game_of_life.test;

import 'package:game_of_life/game_of_life.dart';
import 'package:test/test.dart';

Board makeEmptyBoard() {
  var board = new Board();
  return board;
}

void main() {


  /*
  *  Rules:
  *
  *  1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  *  2. Any live cell with more than three live neighbours dies, as if by overcrowding.
  *  3. Any live cell with two or three live neighbours lives on to the next generation.
  *  4. Any dead cell with exactly three live neighbours becomes a live cell.
  *
  * */

  test('a board can be instantiated', () {
    new Board();
  });

  test('a board is initially empty', () {
    var board = makeEmptyBoard();
    expect(board.isEmpty(), isTrue);
  });

  test('the next state of an empty board is an empty board', () {
    var board = makeEmptyBoard();
    var nextBoard = board.nextState();
    expect(nextBoard.isEmpty(), isTrue);
  });

}
