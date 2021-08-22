import 'package:flutter_snake/app/modules/game_screen/game_screen_args.dart';
import 'package:flutter_snake/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LobbyScreenController extends GetxController {
  final gameFieldRowCount = 10.0.obs;
  final gameFieldColCount = 10.0.obs;
  var isDebugMode = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void setGameFieldRowCount(double value) => gameFieldRowCount.value = value;
  void setGameFieldColCount(double value) => gameFieldColCount.value = value;

  void startGame() {
    Get.toNamed(Routes.GAME_SCREEN,
        arguments: GameScreenArgs(isDebugMode.value,
            gameFieldColCount.value.toInt(), gameFieldRowCount.value.toInt()));
  }
}
