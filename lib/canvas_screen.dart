import 'package:flutter/material.dart';
import 'package:perfect_freehand/perfect_freehand.dart';

class DrawingPoint {
  List<Offset> points;
  Color color;
  double width;

  DrawingPoint({required this.points, required this.color, this.width = 5.0});
}

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<DrawingPoint> history = [];
  DrawingPoint? currentDrawingPoint;
  Color selectedColor = const Color(0xFFF44336); // Red as default
  double strokeWidth = 5.0;
  String selectedTool = 'brush'; // brush, fill, magic, erase

  final List<Color> paletteColors = [
    const Color(0xFFF44336), // Red
    const Color(0xFFFF9800), // Orange
    const Color(0xFFFFEB3B), // Yellow
    const Color(0xFF4CAF50), // Green
    const Color(0xFF2196F3), // Blue
    const Color(0xFF9C27B0), // Purple
    const Color(0xFFE91E63), // Pink
    const Color(0xFF795548), // Brown
    const Color(0xFFFFFFFF), // White
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.onSurface.withOpacity(0.06),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Material(
                        color: colorScheme.surfaceContainerHighest,
                        shape: const CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.home, color: colorScheme.primary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Art Studio',
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.onPrimaryContainer,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          // Handle done action
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Material(
                        color: colorScheme.surfaceContainerHighest,
                        shape: const CircleBorder(),
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Side Tool Dock
                Container(
                  width: 80,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.onSurface.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToolButton('format_paint', 'Fill', 'fill'),
                      const SizedBox(height: 16),
                      _buildToolButton('auto_fix_high', 'Magic', 'magic'),
                      const SizedBox(height: 16),
                      _buildToolButton('ink_eraser', 'Erase', 'erase'),
                    ],
                  ),
                ),
                // Main Canvas Area
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.surfaceContainer,
                        width: 12,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.onSurface.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background Image
                        Center(
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBYN1nAGh9uBujvXeJfrvOhXoymMki9FpEngg2UuMbro-vLLFCNz4wjCxr23KNjKiOWGR5EzmlYifB8kL2ts8QZi0LpXd6_xlCBSM1cVyqAxmI72xDdxIpIOk1TklVthsWfZ0XwyAd_BXjmDsXHV9YMPeOm1I6NOIj_6eNldnjs4FGqIr9g8TWtHuDWwtRDnqp66bv_IQ72Zqt7FcH472lLiXfffpMjBd2_ZlKKBtJ54pCkl4oLqdUvWNGcMe7hiRqjg4cAspGDy3w',
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        // Drawing Layer
                        GestureDetector(
                          onPanStart: selectedTool == 'brush'
                              ? (details) {
                                  setState(() {
                                    currentDrawingPoint = DrawingPoint(
                                      points: [details.localPosition],
                                      color: selectedColor,
                                      width: strokeWidth,
                                    );
                                    if (currentDrawingPoint != null)
                                      history.add(currentDrawingPoint!);
                                  });
                                }
                              : null,
                          onPanUpdate: selectedTool == 'brush'
                              ? (details) {
                                  setState(() {
                                    currentDrawingPoint?.points.add(
                                      details.localPosition,
                                    );
                                  });
                                }
                              : null,
                          onPanEnd: selectedTool == 'brush'
                              ? (_) => currentDrawingPoint = null
                              : null,
                          child: RepaintBoundary(
                            child: CustomPaint(
                              painter: DrawingPainter(drawingPoints: history),
                              child: Container(),
                            ),
                          ),
                        ),
                        // Decorative Sparkle
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Opacity(
                            opacity: 0.2,
                            child: Icon(
                              Icons.stars,
                              size: 48,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Color Palette
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow.withOpacity(0.8),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: paletteColors.length,
                    itemBuilder: (context, index) {
                      final color = paletteColors[index];
                      final isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.onSurface.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: isSelected
                              ? Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colorScheme.primary,
                                      width: 4,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 96,
                  height: 8,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String icon, String label, String tool) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedTool == tool;
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.tertiaryContainer
                : colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: colorScheme.tertiary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: IconButton(
            icon: Icon(
              _getIconData(icon),
              color: isSelected
                  ? colorScheme.onTertiaryContainer
                  : colorScheme.onSurfaceVariant,
            ),
            onPressed: () => setState(() => selectedTool = tool),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'format_paint':
        return Icons.format_paint;
      case 'auto_fix_high':
        return Icons.auto_fix_high;
      case 'ink_eraser':
        return Icons.clear;
      default:
        return Icons.brush;
    }
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawingPoint in drawingPoints) {
      final paint = Paint()
        ..color = drawingPoint.color
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      // Using perfect_freehand to generate a smooth path from points
      final outlinePoints = getStroke(
        drawingPoint.points.map((e) => PointVector(e.dx, e.dy)).toList(),
        options: StrokeOptions(
          size: drawingPoint.width,
          thinning: 0.5,
          smoothing: 0.5,
          streamline: 0.5,
        ),
      );

      final path = Path();
      if (outlinePoints.isNotEmpty) {
        path.moveTo(outlinePoints[0].dx, outlinePoints[0].dy);
        for (int i = 1; i < outlinePoints.length; i++) {
          path.lineTo(outlinePoints[i].dx, outlinePoints[i].dy);
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
