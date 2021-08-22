import 'package:flutter_snake/app/constants.dart';
import 'package:flutter_snake/app/data/coordiante.dart';
import 'package:flutter_snake/app/modules/game_screen/game_logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

main() {
  test('find head', () {
    var gameTile = [
      <int>[-1, 0, 4],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.snakeLength = 4;

    var coord = gs.getHead();

    expect(3, coord.x);
    expect(1, coord.y);
  });

  test('getValueByCoordinate', () {
    var gameTile = [
      <int>[-1, 0, 0],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();

    expect(gs.getValueByCoordinate(Coordinate(2, 1)), 0);
    expect(gs.getValueByCoordinate(Coordinate(1, 1)), -1);
    expect(gs.getValueByCoordinate(Coordinate(3, 2)), 3);
    expect(gs.getValueByCoordinate(Coordinate(2, 3)), 1);
    expect(gs.getValueByCoordinate(Coordinate(3, 3)), 2);
  });

  test('setValueByCoordinate', () {
    var gameTile = [
      <int>[-1, 0, 0],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();

    gs.setValueByCoordinate(Coordinate(1, 2), 4);

    expect(gs.getValueByCoordinate(Coordinate(1, 2)), 4);
  });

  test('Move snake left <--', () {
    var gameTile = [
      <int>[-1, 0, 4],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.LEFT;
    gs.newDirection = Direction.LEFT;

    gs.tick();

    expect(gs.getValueByCoordinate(Coordinate(2, 1)), 4);
    expect(gs.getValueByCoordinate(Coordinate(3, 1)), 3);
    expect(gs.getValueByCoordinate(Coordinate(3, 2)), 2);
    expect(gs.getValueByCoordinate(Coordinate(3, 3)), 1);
    expect(gs.getValueByCoordinate(Coordinate(2, 3)), 0);
  });

  test('IsGameFinished shoud be true hit left wall', () {
    var gameTile = [
      <int>[6, 5, 4],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.LEFT;
    gs.newDirection = Direction.LEFT;

    var isFinished = gs.isGameFinished();

    expect(isFinished, true);
  });

  test('IsGameFinished shoud be true hit top wall', () {
    var gameTile = [
      <int>[6, 5, 4],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.UP;
    gs.newDirection = Direction.UP;

    var isFinished = gs.isGameFinished();

    expect(isFinished, true);
  });

  test('IsGameFinished shoud be true hit right wall', () {
    var gameTile = [
      <int>[0, 0, 4],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.RIGHT;
    gs.newDirection = Direction.RIGHT;

    var isFinished = gs.isGameFinished();

    expect(isFinished, true);
  });

  test('IsGameFinished shoud be true hit bottom wall', () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 0],
      <int>[0, 2, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.DOWN;
    gs.newDirection = Direction.DOWN;

    var isFinished = gs.isGameFinished();

    expect(isFinished, true);
  });

  test(
      'HEAD Bottom LEFT corner keyPressedEvent snake should change direction to UP',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 0],
      <int>[3, 2, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.LEFT;
    gs.newDirection = Direction.LEFT;

    gs.keyPressedEvent('W');

    expect(gs.newDirection, Direction.UP);
  });

  test('HEAD Bottom wall keyPressedEvent snake should change direction to LEFT',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 0],
      <int>[0, 2, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.DOWN;
    gs.newDirection = Direction.DOWN;

    gs.keyPressedEvent('A');

    expect(gs.newDirection, Direction.LEFT);
  });

  test(
      'HEAD Bottom wall keyPressedEvent snake should change direction to RIGHT',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 0],
      <int>[0, 2, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.DOWN;
    gs.newDirection = Direction.DOWN;

    gs.keyPressedEvent('D');

    expect(gs.newDirection, Direction.RIGHT);
  });

  test(
      'HEAD Bottom wall, keyPressedEvent snake should NOT change direction to UP',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 0],
      <int>[0, 2, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.DOWN;
    gs.newDirection = Direction.DOWN;

    gs.keyPressedEvent('W');

    expect(gs.newDirection, Direction.DOWN);
  });

  test('HEAD left wall keyPressedEvent snake should change direction to UP',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[2, 1, 0],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.LEFT;
    gs.newDirection = Direction.LEFT;

    gs.keyPressedEvent('W');

    expect(gs.newDirection, Direction.UP);
  });

  test('HEAD left wall keyPressedEvent snake should change direction to DOWN',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[2, 1, 0],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.DOWN;
    gs.newDirection = Direction.DOWN;

    gs.keyPressedEvent('S');

    expect(gs.newDirection, Direction.DOWN);
  });

  test(
      'HEAD left wall keyPressedEvent snake should NOT change direction to RIGHT',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[2, 1, 0],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.LEFT;
    gs.newDirection = Direction.LEFT;

    gs.keyPressedEvent('D');

    expect(gs.newDirection, Direction.LEFT);
  });

  test('HEAD top wall keyPressedEvent snake should change direction to LEFT',
      () {
    var gameTile = [
      <int>[0, 2, 0],
      <int>[0, 1, 0],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.UP;
    gs.newDirection = Direction.UP;

    gs.keyPressedEvent('A');

    expect(gs.newDirection, Direction.LEFT);
  });

  test('HEAD top wall keyPressedEvent snake should change direction to RIGHT',
      () {
    var gameTile = [
      <int>[0, 2, 0],
      <int>[0, 1, 0],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.UP;
    gs.newDirection = Direction.UP;

    gs.keyPressedEvent('D');

    expect(gs.newDirection, Direction.RIGHT);
  });

  test(
      'HEAD top wall keyPressedEvent snake should NOT change direction to DOWN',
      () {
    var gameTile = [
      <int>[0, 2, 0],
      <int>[0, 1, 0],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.UP;
    gs.newDirection = Direction.UP;

    gs.keyPressedEvent('S');

    expect(gs.newDirection, Direction.UP);
  });

  test('HEAD RIGHT wall keyPressedEvent snake should change direction to UP',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 2],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.RIGHT;
    gs.newDirection = Direction.RIGHT;

    gs.keyPressedEvent('W');

    expect(gs.newDirection, Direction.UP);
  });

  test('HEAD RIGHT wall keyPressedEvent snake should change direction to DOWN',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 2],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.RIGHT;
    gs.newDirection = Direction.RIGHT;

    gs.keyPressedEvent('S');

    expect(gs.newDirection, Direction.DOWN);
  });

  test(
      'HEAD RIGHT wall keyPressedEvent snake should NOT change direction to LEFT',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 1, 2],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.RIGHT;
    gs.newDirection = Direction.RIGHT;

    gs.keyPressedEvent('A');

    expect(gs.newDirection, Direction.RIGHT);
  });

  test('HEAD RIGHT wall keyPressedEvent snake should change direction to LEFT',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[0, 0, 3],
      <int>[0, 1, 2],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.UP;
    gs.newDirection = Direction.RIGHT;

    gs.keyPressedEvent('A');

    expect(gs.newDirection, Direction.LEFT);
  });

  test(
      'HEAD RIGHT BOTTOM corner keyPressedEvent snake should NOT change direction to UP',
      () {
    var gameTile = [
      <int>[0, 0, 0],
      <int>[3, 2, 1],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);

    gs.init();
    gs.previousDirection = Direction.LEFT;
    gs.newDirection = Direction.LEFT;
    gs.keyPressedEvent('S');
    gs.tick();

    gs.keyPressedEvent('W');

    expect(gs.newDirection, Direction.DOWN);
    expect(gs.newDirection, Direction.DOWN);
  });

  test('Next step is food, snake should increase it\'s size', () {
    var gameTile = [
      <int>[-1, 0, 0],
      <int>[3, 2, 1],
      <int>[0, 0, 0],
    ].obs;
    var gs = GameLogic.gameField(gameTile: gameTile);
    gs.init();
    gs.previousDirection = Direction.UP;
    gs.newDirection = Direction.UP;

    gs.tick();

    expect(gs.newDirection, Direction.UP);
    expect(gs.getValueByCoordinate(Coordinate(1, 1)), 4);
    expect(gs.getValueByCoordinate(Coordinate(1, 2)), 3);
    expect(gs.getValueByCoordinate(Coordinate(2, 2)), 2);
    expect(gs.getValueByCoordinate(Coordinate(3, 2)), 1);
    expect(gs.snakeLength, 4);
  });
}
