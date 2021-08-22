import 'package:get/get.dart';

import 'package:flutter_snake/app/modules/game_screen/game_screen_binding.dart';
import 'package:flutter_snake/app/modules/game_screen/game_screen_view.dart';
import 'package:flutter_snake/app/modules/lobby_screen/lobby_screen_binding.dart';
import 'package:flutter_snake/app/modules/lobby_screen/lobby_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOBBY_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.GAME_SCREEN,
      page: () => GameScreenView(),
      binding: GameScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOBBY_SCREEN,
      page: () => LobbyScreenView(),
      binding: LobbyScreenBinding(),
    ),
  ];
}
