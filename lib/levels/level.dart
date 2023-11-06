// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/constants.dart';

class Level extends World {
  Level({
    required this.levelName,
    required this.player,
  });

  late TiledComponent level;
  final String levelName;
  final Player player;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);

    final spawnPointLayer =
        level.tileMap.getLayer<ObjectGroup>(kSpawnPointLayerName);

    for (final spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case kPlayerObjectName:
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
          break;
      }
    }
    return super.onLoad();
  }
}
