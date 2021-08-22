import 'dart:async';
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter_snake/app/constants.dart';
import 'package:flutter_snake/app/data/coordiante.dart';
import 'package:get/get.dart';

class GameLogic {
  var gameTile = [].obs;
  bool isGameEnded = false;
  Direction previousDirection = Direction.RIGHT;
  Direction newDirection = Direction.RIGHT;
  RxString directionText = ''.obs;
  late Coordinate headCoordinate;
  var isShowSnakeAsNumbers = false.obs;
  var isDebugMode = true.obs;
  int snakeLength = 0;
  Timer? _timer;

  GameLogic(
      {required int colCount,
      required int rowCount,
      required bool isDebugMode}) {
    this.isDebugMode.value = isDebugMode;
    gameTile.clear();
    for (var i = 0; i < rowCount; i++) {
      gameTile.add(<int>[]);
      gameTile[i].addAll(List.filled(colCount, 0));
    }

    setValueByCoordinate(Coordinate(2, 2), 2);
    setValueByCoordinate(Coordinate(1, 2), 1);

    placeFoodToEmptySpace();

    init();
  }

  GameLogic.gameField({required this.gameTile});

  void init() {
    headCoordinate = getHead();
    directionText.value = previousDirection.toString();
    if (isDebugMode.isFalse) {
      print('start timer');
      _timer = Timer.periodic(Duration(milliseconds: 300), onTick);
    }
  }

  void keyPressedEvent(String character) {
    print(character);
    headCoordinate = getHead();
    if (character == 'W' || character == 'w') {
      _tryTochangeDirectionTo(Direction.UP);
    } else if (character == 'D' || character == 'd') {
      _tryTochangeDirectionTo(Direction.RIGHT);
    } else if (character == 'S' || character == 's') {
      _tryTochangeDirectionTo(Direction.DOWN);
    } else if (character == 'A' || character == 'a') {
      _tryTochangeDirectionTo(Direction.LEFT);
    }
  }

  void _tryTochangeDirectionTo(Direction newDirection) {
    if (isPossibleTochangeDirectionTo(newDirection)) {
      log('Direction from ${previousDirection.toString()} changed to ${newDirection.toString()} ');
      this.newDirection = newDirection;
      directionText.value = newDirection.toString();
    }
  }

  bool isPossibleTochangeDirectionTo(Direction newDirection) {
    switch (newDirection) {
      case Direction.UP:
        return previousDirection != Direction.DOWN;
      case Direction.RIGHT:
        return previousDirection != Direction.LEFT;
      case Direction.DOWN:
        return previousDirection != Direction.UP;
      case Direction.LEFT:
        return previousDirection != Direction.RIGHT;
    }
  }

  void tick() {
    updateSnakeLenght();
    updateHeadCoordinate();

    if (isGameFinished()) {
      if (isDebugMode.isFalse) {
        _timer?.cancel();
        Get.back();
      }
      return;
    }

    if (isNextStepIsFood()) {
      snakeLength++;
      placeFoodToEmptySpace();
    } else {
      moveSnake();
    }
    moveHead();
    previousDirection = newDirection;
    gameTile.refresh();
  }

  void moveSnake() {
    forEachGameTile((coordinate) {
      var value = getValueByCoordinate(coordinate);
      if (value > 0)
        setValueByCoordinate(coordinate, getValueByCoordinate(coordinate) - 1);
    });
  }

  void moveHead() {
    switch (newDirection) {
      case Direction.UP:
        setValueByCoordinate(
            Coordinate(headCoordinate.x, headCoordinate.y - 1), snakeLength);
        ;
        break;
      case Direction.RIGHT:
        setValueByCoordinate(
            Coordinate(headCoordinate.x + 1, headCoordinate.y), snakeLength);
        break;
      case Direction.DOWN:
        setValueByCoordinate(
            Coordinate(headCoordinate.x, headCoordinate.y + 1), snakeLength);
        ;
        break;
      case Direction.LEFT:
        return setValueByCoordinate(
            Coordinate(headCoordinate.x - 1, headCoordinate.y), snakeLength);
    }
  }

  updateHeadCoordinate() {
    headCoordinate = getHead();
  }

  Coordinate getHead() {
    updateSnakeLenght();

    Coordinate? coordinateResult;
    forEachGameTile((coordinate) {
      var value = getValueByCoordinate(coordinate);
      if (value == snakeLength && value > 0) {
        coordinateResult = coordinate;
        return;
      }
    });

    if (coordinateResult != null) return coordinateResult!;

    throw Exception('Unable to find head');
  }

  void updateSnakeLenght() {
    var length = 0;
    forEachGameTile((coordinate) {
      if (getValueByCoordinate(coordinate) > length)
        length = getValueByCoordinate(coordinate);
    });

    snakeLength = length;
  }

  int getValueByCoordinate(Coordinate coordinate) {
    return gameTile[coordinate.y - 1][coordinate.x - 1];
  }

  void setValueByCoordinate(Coordinate coordinate, int value) {
    gameTile[coordinate.y - 1][coordinate.x - 1] = value;
  }

  int getColCount() {
    return gameTile[0].length;
  }

  int getRowCount() {
    return gameTile.length;
  }

  bool isGameFinished() {
    return isNexStepIsWall() || isNextStepIsTail();
  }

  bool isNexStepIsWall() {
    if (newDirection == Direction.LEFT && headCoordinate.x == 1) {
      print('end game: Hit left wall');
      return true;
    }

    if (newDirection == Direction.UP && headCoordinate.y == 1) {
      print('end game: Hit Top wall');
      return true;
    }

    if (newDirection == Direction.RIGHT && headCoordinate.x == getColCount()) {
      print('end game: Hit Right wall');
      return true;
    }

    if (newDirection == Direction.DOWN && headCoordinate.y == getRowCount()) {
      print('end game: Hit Bottom wall');
      return true;
    }
    return false;
  }

  bool isNextStepIsTail() {
    switch (newDirection) {
      case Direction.UP:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x, headCoordinate.y - 1)) >
            0;
      case Direction.RIGHT:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x + 1, headCoordinate.y)) >
            0;
      case Direction.DOWN:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x, headCoordinate.y + 1)) >
            0;
      case Direction.LEFT:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x - 1, headCoordinate.y)) >
            0;
    }
  }

  bool isNextStepIsFood() {
    switch (newDirection) {
      case Direction.UP:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x, headCoordinate.y - 1)) ==
            -1;
      case Direction.RIGHT:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x + 1, headCoordinate.y)) ==
            -1;
      case Direction.DOWN:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x, headCoordinate.y + 1)) ==
            -1;
      case Direction.LEFT:
        return getValueByCoordinate(
                Coordinate(headCoordinate.x - 1, headCoordinate.y)) ==
            -1;
    }
  }

  void placeFoodToEmptySpace() {
    var emptyCoordinates = <Coordinate>[];
    forEachGameTile((coordinate) {
      emptyCoordinates.addIf(getValueByCoordinate(coordinate) == 0, coordinate);
    });
    if (emptyCoordinates.length == 0) {
      print('You win. The End');
      return;
    }
    setValueByCoordinate(emptyCoordinates.sample(1).first, -1);
  }

  void forEachGameTile(void action(Coordinate coordinate)) {
    for (int row = 1; row <= getRowCount(); row++) {
      for (var col = 1; col <= getColCount(); col++) {
        action(Coordinate(col, row));
      }
    }
  }

  void onTick(Timer timer) {
    tick();
  }
}
