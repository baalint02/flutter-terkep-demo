import 'package:flutter/widgets.dart';
import 'package:honfoglalo/map_loader.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class MapModel with ChangeNotifier {
  final List<bool> selected = List.filled(19, false);

  void flip(int index) {
    selected[index] = !selected[index];
    notifyListeners();
  }
}

class MapWidget extends StatelessWidget {
  final MapDrawing drawing;

  const MapWidget(this.drawing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(drawing.fieldPaths.length.toString());
    return Container(
      width: 1000,
      height: 615,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 230, 238, 238)),
      child: ChangeNotifierProvider<MapModel>(
        create: (_) => MapModel(),
        child: Stack(
          alignment: Alignment.center,
          children: drawing.fieldPaths
              .mapIndexed((index, shape) => SizedBox.fromSize(
                  size: drawing.size, child: CountyWidget(index, shape)))
              .toList(),
        ),
      ),
    );
  }
}

class CountyWidget extends StatelessWidget {
  final int index;
  final Path shape;

  const CountyWidget(this.index, this.shape, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapModel model = context.watch<MapModel>();
    return GestureDetector(
      onTap: (() {
        debugPrint("clicked $index");
        model.flip(index);
      }),
      child: CustomPaint(
        painter: FieldPainter(shape, model.selected[index]),
      ),
    );
  }
}

class FieldPainter extends CustomPainter {
  final Path shape;
  final bool selected;

  FieldPainter(this.shape, this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = selected
          ? const Color.fromARGB(255, 17, 167, 0)
          : const Color.fromARGB(255, 1, 88, 129);
    canvas.drawPath(shape, fillPaint);
    final borderPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(shape, borderPaint);
  }

  @override
  bool shouldRepaint(covariant FieldPainter oldDelegate) {
    return oldDelegate.selected != selected;
  }

  @override
  bool? hitTest(Offset position) {
    return shape.contains(position);
  }
}
