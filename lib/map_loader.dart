import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;

class MapDrawing {
  Size size;
  List<Path> fieldPaths;

  MapDrawing(this.size, this.fieldPaths);
}

Future<MapDrawing> loadMapDrawing() async {
  final List<Path> fieldPaths = [];
  fieldPaths
    ..add(await loadFieldPath("1"))
    ..add(await loadFieldPath("2"))
    ..add(await loadFieldPath("3"))
    ..add(await loadFieldPath("4"))
    ..add(await loadFieldPath("5"))
    ..add(await loadFieldPath("6"))
    ..add(await loadFieldPath("7"))
    ..add(await loadFieldPath("8"))
    ..add(await loadFieldPath("9"))
    ..add(await loadFieldPath("10"))
    ..add(await loadFieldPath("11"))
    ..add(await loadFieldPath("12"))
    ..add(await loadFieldPath("13"))
    ..add(await loadFieldPath("14"))
    ..add(await loadFieldPath("15"))
    ..add(await loadFieldPath("16"))
    ..add(await loadFieldPath("17"))
    ..add(await loadFieldPath("18"))
    ..add(await loadFieldPath("19"));
  return MapDrawing(const Size(1000, 615), fieldPaths);
}

Future<Path> loadFieldPath(String id) {
  return rootBundle.loadStructuredData("assets/map/fields/$id.path",
      ((value) async {
    final points = value.split("\n").map((line) {
      final coords = line.split(" ").map((e) => double.parse(e));

      return Point(coords.first, coords.last);
    }).toList();

    final Path path = Path();
    path.moveTo(points[0].x, points[0].y);
    for (var vertex in points.sublist(1)) {
      path.lineTo(vertex.x, vertex.y);
    }
    path.close();
    return path;
  }));
}
