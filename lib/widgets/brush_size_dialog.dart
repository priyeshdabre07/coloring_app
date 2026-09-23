import 'package:flutter/material.dart';
import 'bouncy_button.dart';

class BrushSizeDialog extends StatelessWidget {
  final double currentSize;
  final ValueChanged<double> onSizeSelected;

  const BrushSizeDialog({
    super.key,
    required this.currentSize,
    required this.onSizeSelected,
  });

  static const List<Map<String, dynamic>> sizes = [
    {'label': 'Fine', 'size': 5.0, 'iconSize': 10.0, 'emoji': '✏️'},
    {'label': 'Medium', 'size': 12.0, 'iconSize': 18.0, 'emoji': '🖍️'},
    {'label': 'Thick', 'size': 24.0, 'iconSize': 28.0, 'emoji': '🖌️'},
    {'label': 'Jumbo', 'size': 44.0, 'iconSize': 42.0, 'emoji': '🌟'},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: const Color(0xFFFFFEEB),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text('🎨', style: TextStyle(fontSize: 28)),
                    SizedBox(width: 8),
                    Text(
                      'Crayon Size',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF363A18),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF776300)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sizes.map((item) {
                final double sizeVal = item['size'] as double;
                final bool isSelected = (currentSize - sizeVal).abs() < 4.0;
                final String label = item['label'] as String;
                final String emoji = item['emoji'] as String;

                return Column(
                  children: [
                    BouncyButton(
                      padding: const EdgeInsets.all(16),
                      color: isSelected
                          ? const Color(0xFFFFD709)
                          : Colors.white,
                      borderWidth: isSelected ? 3 : 1.5,
                      borderColor: isSelected
                          ? const Color(0xFF776300)
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                      onPressed: () {
                        onSizeSelected(sizeVal);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 8),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF6F6C8),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Center(
                              child: Container(
                                width: sizeVal.clamp(6.0, 36.0),
                                height: sizeVal.clamp(6.0, 36.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF363A18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: const Color(0xFF363A18),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
