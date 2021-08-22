import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_screen_controller.dart';

class GameScreenView extends GetView<GameScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GameScreenView'),
        centerTitle: true,
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          controller.gameLogic.keyPressedEvent(event.character ?? '');
        },
        child: Obx(
          () => Stack(
            children: [
              if (controller.gameLogic.isDebugMode.isTrue)
                Positioned(
                  child: Text(controller.gameLogic.directionText.value),
                ),
              if (controller.gameLogic.isDebugMode.isTrue)
                Positioned(
                  top: 30,
                  child: TextButton(
                    child: Text('Move snake'),
                    onPressed: () {
                      controller.gameLogic.tick();
                    },
                  ),
                ),
              if (controller.gameLogic.isDebugMode.isTrue)
                Positioned(
                  right: 20,
                  child: Row(
                    children: [
                      Text('Show game field as numbers?'),
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                        value: controller.gameLogic.isShowSnakeAsNumbers.value,
                        onChanged: (value) =>
                            controller.gameLogic.isShowSnakeAsNumbers(value),
                      ),
                    ],
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...controller.gameLogic.gameTile.map(
                    (element) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...element
                            .map((e) => getTileByValue(e) //Text(e.toString()),
                                ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTileByValue(int value) {
    Color color;
    if (controller.gameLogic.isShowSnakeAsNumbers.value)
      color = Colors.white;
    else if (value == -1)
      color = Colors.green;
    else if (value > 0)
      color = Colors.black87;
    else
      color = Colors.grey[300]!;

    return getTile(
        color,
        controller.gameLogic.isShowSnakeAsNumbers.value
            ? getDebugNumbers(value)
            : null);
  }

  Widget getTile(Color color, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: color,
        width: 25,
        height: 25,
        child: child,
      ),
    );
  }

  Widget getDebugNumbers(int value) {
    return Text(
      value.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
