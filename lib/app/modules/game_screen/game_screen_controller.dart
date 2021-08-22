import 'package:flutter_snake/app/modules/game_screen/game_logic.dart';
import 'package:flutter_snake/app/modules/game_screen/game_screen_args.dart';
import 'package:get/get.dart';

class GameScreenController extends GetxController {
  late GameLogic gameLogic;

  @override
  void onInit() {
    super.onInit();
    GameScreenArgs? args = Get.arguments;
    if (args != null) {
      gameLogic = GameLogic(
          colCount: args.colCount,
          rowCount: args.rowCount,
          isDebugMode: args.isDebug);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
