import 'package:flutter/material.dart';

class ArrowTabBarIndicator extends Decoration {
  final BoxPainter _painter;
  ArrowTabBarIndicator({double width = 20, double height = 10, Color color = Colors.green})
      : _painter = _ArrowPainter(width, height,color);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _ArrowPainter extends BoxPainter {
  final Paint _paint;
  final double width;
  final double height;
  final Color color;

  _ArrowPainter(this.width, this.height,this.color)
      : _paint = Paint()
    ..color = Colors.green
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Path _trianglePath = Path();
    if (cfg.size != null){

      Offset centerTop = Offset(cfg.size!.width / 2, cfg.size!.height - height) + offset;
      Offset bottomLeft = Offset(cfg.size!.width / 2 - (width/2), cfg.size!.height) + offset;
      Offset bottomRight = Offset(cfg.size!.width / 2 + (width/2), cfg.size!.height) + offset;

      _trianglePath.moveTo(bottomLeft.dx, bottomLeft.dy);
      _trianglePath.lineTo(bottomRight.dx, bottomRight.dy);
      _trianglePath.lineTo(centerTop.dx, centerTop.dy);
      _trianglePath.lineTo(bottomLeft.dx, bottomLeft.dy);

      _trianglePath.close();
      canvas.drawPath(_trianglePath, _paint);
    }
  }
}