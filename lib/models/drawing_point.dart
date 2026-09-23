import 'package:flutter/material.dart';

enum ToolType {
  brush,
  rainbow,
  eraser,
  stamp,
}

class DrawingPoint {
  List<Offset> points;
  Color color;
  double width;
  ToolType toolType;

  DrawingPoint({
    required this.points,
    required this.color,
    this.width = 8.0,
    this.toolType = ToolType.brush,
  });
}

class StickerItem {
  final String id;
  final String emoji;
  final String label;
  final Offset position;
  final double scale;

  const StickerItem({
    required this.id,
    required this.emoji,
    required this.label,
    required this.position,
    this.scale = 1.0,
  });

  StickerItem copyWith({Offset? position, double? scale}) {
    return StickerItem(
      id: id,
      emoji: emoji,
      label: label,
      position: position ?? this.position,
      scale: scale ?? this.scale,
    );
  }
}
