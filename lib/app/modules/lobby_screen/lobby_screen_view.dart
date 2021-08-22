import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lobby_screen_controller.dart';

class LobbyScreenView extends GetView<LobbyScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.startGame();
                },
                child: Text('StartGame'),
                style: ElevatedButton.styleFrom(primary: Colors.green[300]),
              ),
              SizedBox(
                width: 20,
              ),
              Text('IsDebugMode'),
              Checkbox(
                  value: controller.isDebugMode.value,
                  onChanged: controller.isDebugMode),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              child: Row(
                children: [
                  Text('Row Count'),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      label:
                          controller.gameFieldRowCount.value.round().toString(),
                      min: 4,
                      max: 40,
                      divisions: 36,
                      value: controller.gameFieldRowCount.value,
                      onChanged: (value) =>
                          controller.setGameFieldRowCount(value),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Controls'),
                        Image.asset('assets/controls.png'),
                        SizedBox(
                          height: 50,
                        ),
                        Text('Column Count'),
                        Slider(
                          label: controller.gameFieldColCount.value
                              .round()
                              .toString(),
                          value: controller.gameFieldColCount.value,
                          min: 4,
                          max: 40,
                          divisions: 36,
                          onChanged: (value) =>
                              controller.setGameFieldColCount(value),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
