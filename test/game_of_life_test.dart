// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library game_of_life.test;

import 'package:game_of_life/game_of_life.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}
