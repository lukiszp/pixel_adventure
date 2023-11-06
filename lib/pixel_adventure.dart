import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/constants.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(kBackgroundColor);

  late final CameraComponent cam;
  Player player = Player();
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    final world = Level(
      levelName: 'Level-01',
      player: player,
    );

    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: world);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    addJoystick();

    return super.onLoad();
  }

  void addJoystick() {
    joystick = JoystickComponent();
  }
}
