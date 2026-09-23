import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:perfect_freehand/perfect_freehand.dart';

import 'models/drawing_point.dart';
import 'models/drawing_template.dart';
import 'models/saved_artwork.dart';
import 'painters/template_painters.dart';
import 'services/gallery_service.dart';
import 'widgets/bouncy_button.dart';
import 'widgets/brush_size_dialog.dart';
import 'widgets/confetti_celebration.dart';
import 'widgets/sticker_sheet.dart';

class CanvasScreen extends StatefulWidget {
  final DrawingTemplate? template;

  const CanvasScreen({super.key, this.template});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final GlobalKey _canvasKey = GlobalKey();

  // History for Undo / Redo
  final List<DrawingPoint> _strokes = [];
  final List<DrawingPoint> _undoneStrokes = [];
  final List<StickerItem> _stickers = [];
  final List<StickerItem> _undoneStickers = [];

  DrawingPoint? _currentPoint;
  Color _selectedColor = const Color(0xFFFF5252); // Bright red default
  double _strokeWidth = 12.0; // Medium default
  ToolType _currentTool = ToolType.brush;
  String? _selectedStickerEmoji;
  double _rainbowHue = 0.0;

  final List<Color> _paletteColors = const [
    Color(0xFFFF5252), // Bright Red
    Color(0xFFFF7A00), // Orange
    Color(0xFFFFD709), // Sunny Yellow
    Color(0xFF76FF03), // Lime Green
    Color(0xFF00E676), // Bright Green
    Color(0xFF00E5FF), // Aqua
    Color(0xFF2979FF), // Sky Blue
    Color(0xFF651FFF), // Indigo
    Color(0xFFD500F9), // Purple
    Color(0xFFFF4081), // Pink
    Color(0xFFFF80AB), // Soft Pink
    Color(0xFF8D6E63), // Brown
    Color(0xFF37474F), // Slate Charcoal
    Color(0xFFFFFFFF), // White
  ];

  DrawingTemplate get _template =>
      widget.template ?? DrawingTemplate.allTemplates.first;

  void _onPanStart(DragStartDetails details) {
    if (_currentTool == ToolType.stamp) {
      if (_selectedStickerEmoji != null) {
        setState(() {
          _stickers.add(
            StickerItem(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              emoji: _selectedStickerEmoji!,
              label: 'Sticker',
              position: details.localPosition,
            ),
          );
          _undoneStickers.clear();
        });
      }
      return;
    }

    setState(() {
      Color strokeColor = _selectedColor;
      if (_currentTool == ToolType.eraser) {
        strokeColor = const Color(0xFFFFFEEB); // Match canvas paper color
      } else if (_currentTool == ToolType.rainbow) {
        strokeColor = HSVColor.fromAHSV(1.0, _rainbowHue, 1.0, 1.0).toColor();
        _rainbowHue = (_rainbowHue + 15) % 360;
      }

      _currentPoint = DrawingPoint(
        points: [details.localPosition],
        color: strokeColor,
        width: _currentTool == ToolType.eraser ? _strokeWidth * 1.8 : _strokeWidth,
        toolType: _currentTool,
      );

      _strokes.add(_currentPoint!);
      _undoneStrokes.clear();
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_currentTool == ToolType.stamp || _currentPoint == null) return;

    setState(() {
      _currentPoint!.points.add(details.localPosition);

      // Rainbow magic brush continuously cycles colors!
      if (_currentTool == ToolType.rainbow) {
        _rainbowHue = (_rainbowHue + 4) % 360;
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _currentPoint = null;
  }

  void _undo() {
    setState(() {
      if (_strokes.isNotEmpty) {
        _undoneStrokes.add(_strokes.removeLast());
      } else if (_stickers.isNotEmpty) {
        _undoneStickers.add(_stickers.removeLast());
      }
    });
  }

  void _redo() {
    setState(() {
      if (_undoneStrokes.isNotEmpty) {
        _strokes.add(_undoneStrokes.removeLast());
      } else if (_undoneStickers.isNotEmpty) {
        _stickers.add(_undoneStickers.removeLast());
      }
    });
  }

  void _clearCanvas() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: const Color(0xFFFFFEEB),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🧼', style: TextStyle(fontSize: 44)),
              const SizedBox(height: 12),
              const Text(
                'Start Over?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF363A18),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Do you want to clean your canvas and start fresh?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF776300), fontSize: 14),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BouncyButton(
                    color: Colors.white,
                    borderWidth: 1.5,
                    borderColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  BouncyButton(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    onPressed: () {
                      setState(() {
                        _strokes.clear();
                        _undoneStrokes.clear();
                        _stickers.clear();
                        _undoneStickers.clear();
                      });
                      Navigator.pop(ctx);
                    },
                    child: const Text(
                      'Clear 🎨',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDone() async {
    try {
      final boundary = _canvasKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      ui.Image? image;
      if (boundary != null) {
        image = await boundary.toImage(pixelRatio: 2.0);
      }
      final byteData =
          await image?.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData?.buffer.asUint8List();

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ConfettiCelebrationDialog(
          title: _template.title,
          imageBytes: bytes,
          onSave: () {
            final saved = SavedArtwork(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: _template.title,
              templateId: _template.id,
              date: DateTime.now(),
              imageBytes: bytes,
              strokesCount: _strokes.length,
              stickersCount: _stickers.length,
            );
            GalleryService().saveArtwork(saved);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Saved to My Masterpieces Gallery! ⭐'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          onContinue: () {},
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Great job coloring!')),
      );
    }
  }

  void _openSizeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => BrushSizeDialog(
        currentSize: _strokeWidth,
        onSizeSelected: (size) => setState(() => _strokeWidth = size),
      ),
    );
  }

  void _openStickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StickerSheet(
        onStickerSelected: (emoji) {
          setState(() {
            _selectedStickerEmoji = emoji;
            _currentTool = ToolType.stamp;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tap anywhere on the drawing to stamp $emoji!'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDD9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(74),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFEEB),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BouncyButton(
                        padding: const EdgeInsets.all(10),
                        color: const Color(0xFFFFD709),
                        borderRadius: BorderRadius.circular(16),
                        elevation: 3,
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Color(0xFF5B4B00)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(_template.iconEmoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 6),
                              Text(
                                _template.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF776300),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Art Studio',
                            style: TextStyle(fontSize: 11, color: Color(0xFF363A18)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Undo Button
                      IconButton(
                        icon: Icon(
                          Icons.undo,
                          color: (_strokes.isNotEmpty || _stickers.isNotEmpty)
                              ? const Color(0xFF776300)
                              : Colors.black26,
                        ),
                        onPressed: (_strokes.isNotEmpty || _stickers.isNotEmpty) ? _undo : null,
                      ),
                      // Redo Button
                      IconButton(
                        icon: Icon(
                          Icons.redo,
                          color: (_undoneStrokes.isNotEmpty || _undoneStickers.isNotEmpty)
                              ? const Color(0xFF776300)
                              : Colors.black26,
                        ),
                        onPressed: (_undoneStrokes.isNotEmpty || _undoneStickers.isNotEmpty) ? _redo : null,
                      ),
                      // Clear Canvas Button
                      IconButton(
                        icon: const Icon(Icons.cleaning_services_outlined, color: Color(0xFF776300)),
                        onPressed: _clearCanvas,
                      ),
                      const SizedBox(width: 8),
                      // Done Button
                      BouncyButton(
                        color: const Color(0xFFFFD709),
                        borderWidth: 2,
                        borderColor: const Color(0xFF776300),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        elevation: 4,
                        onPressed: _handleDone,
                        child: const Row(
                          children: [
                            Text(
                              'Done',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Color(0xFF5B4B00),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('⭐', style: TextStyle(fontSize: 14)),
                          ],
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
                // Left Tool Dock
                _buildLeftToolDock(),

                // Center Drawing Canvas
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 12, 16, 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFEEB),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: const Color(0xFFFFD709), width: 8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RepaintBoundary(
                        key: _canvasKey,
                        child: Stack(
                          children: [
                            // 1. Vector Template Underlay Guide (subtle guide)
                            if (!_template.isBlankCanvas)
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: TemplateOutlineWidget(
                                    templateId: _template.id,
                                    outlineColor: const Color(0xFFE8DFB8),
                                    strokeWidth: 4.0,
                                  ),
                                ),
                              ),

                            // 2. Gesture Drawing Surface (between fill and outline)
                            Positioned.fill(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onPanStart: _onPanStart,
                                onPanUpdate: _onPanUpdate,
                                onPanEnd: _onPanEnd,
                                child: CustomPaint(
                                  painter: KidsDrawingPainter(
                                    strokes: _strokes,
                                    currentPoint: _currentPoint,
                                  ),
                                  size: Size.infinite,
                                ),
                              ),
                            ),

                            // 3. Stickers Layer
                            ..._stickers.map((sticker) {
                              return Positioned(
                                left: sticker.position.dx - 24,
                                top: sticker.position.dy - 24,
                                child: IgnorePointer(
                                  child: Text(
                                    sticker.emoji,
                                    style: const TextStyle(fontSize: 44),
                                  ),
                                ),
                              );
                            }),

                            // 4. Vector Cartoon Outline Layer (Thick crisp black cartoon lines over coloring)
                            if (!_template.isBlankCanvas)
                              Positioned.fill(
                                child: IgnorePointer(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: TemplateOutlineWidget(
                                      templateId: _template.id,
                                      outlineColor: const Color(0xFF2D251E),
                                      strokeWidth: 4.5,
                                      fillShapes: false,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Kid Color Palette
          _buildBottomPalette(),
        ],
      ),
    );
  }

  Widget _buildLeftToolDock() {
    return Container(
      width: 72,
      margin: const EdgeInsets.fromLTRB(16, 12, 0, 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEEB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFD709), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToolItem(ToolType.brush, '🖌️', 'Marker'),
            const SizedBox(height: 8),
            _buildToolItem(ToolType.rainbow, '🌈', 'Magic'),
            const SizedBox(height: 8),
            _buildToolItem(ToolType.eraser, '🧼', 'Eraser'),
            const SizedBox(height: 8),
            _buildToolItem(ToolType.stamp, '⭐', 'Stamp', onTap: _openStickerSheet),
            const Divider(indent: 12, endIndent: 12, color: Colors.black12, height: 16),
            // Size Picker Tool
            GestureDetector(
              onTap: _openSizeDialog,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD709).withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: _strokeWidth.clamp(6.0, 22.0),
                        height: _strokeWidth.clamp(6.0, 22.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF363A18),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF363A18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolItem(
    ToolType tool,
    String emoji,
    String label, {
    VoidCallback? onTap,
  }) {
    final isSelected = _currentTool == tool;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          setState(() => _currentTool = tool);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFD709) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: const Color(0xFF776300), width: 2) : null,
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: const Color(0xFF363A18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPalette() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEEB),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: const Color(0xFFFFD709), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _paletteColors.length + 1,
        itemBuilder: (context, index) {
          // Index 0: Rainbow Magic Quick Swatch
          if (index == 0) {
            final isRainbowSelected = _currentTool == ToolType.rainbow;
            return GestureDetector(
              onTap: () {
                setState(() => _currentTool = ToolType.rainbow);
              },
              child: Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const SweepGradient(
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                      Colors.purple,
                      Colors.red,
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isRainbowSelected ? const Color(0xFF776300) : Colors.white,
                    width: isRainbowSelected ? 4 : 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🌈', style: TextStyle(fontSize: 22)),
                ),
              ),
            );
          }

          final color = _paletteColors[index - 1];
          final isSelected = _selectedColor == color && _currentTool != ToolType.rainbow && _currentTool != ToolType.eraser;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = color;
                if (_currentTool == ToolType.eraser || _currentTool == ToolType.rainbow) {
                  _currentTool = ToolType.brush;
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: isSelected ? 58 : 50,
              height: isSelected ? 58 : 50,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF776300) : Colors.white,
                  width: isSelected ? 4.5 : 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.check, color: Colors.white, size: 24),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class KidsDrawingPainter extends CustomPainter {
  final List<DrawingPoint> strokes;
  final DrawingPoint? currentPoint;

  KidsDrawingPainter({
    required this.strokes,
    this.currentPoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _paintStroke(canvas, stroke);
    }
    if (currentPoint != null) {
      _paintStroke(canvas, currentPoint!);
    }
  }

  void _paintStroke(Canvas canvas, DrawingPoint stroke) {
    if (stroke.points.isEmpty) return;

    final paint = Paint()
      ..color = stroke.color
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (stroke.points.length == 1) {
      canvas.drawCircle(stroke.points.first, stroke.width / 2, paint);
      return;
    }

    final outlinePoints = getStroke(
      stroke.points.map((p) => PointVector(p.dx, p.dy)).toList(),
      options: StrokeOptions(
        size: stroke.width,
        thinning: 0.3,
        smoothing: 0.6,
        streamline: 0.4,
      ),
    );

    if (outlinePoints.isNotEmpty) {
      final path = Path()..moveTo(outlinePoints[0].dx, outlinePoints[0].dy);
      for (int i = 1; i < outlinePoints.length; i++) {
        path.lineTo(outlinePoints[i].dx, outlinePoints[i].dy);
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant KidsDrawingPainter oldDelegate) => true;
}
