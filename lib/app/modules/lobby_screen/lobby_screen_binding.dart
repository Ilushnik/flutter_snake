import 'package:get/get.dart';

import 'lobby_screen_controller.dart';

class LobbyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LobbyScreenController>(
      () => LobbyScreenController(),
    );
  }
}
