import 'package:flutter/material.dart';
import 'bouncy_button.dart';

class StickerSheet extends StatelessWidget {
  final ValueChanged<String> onStickerSelected;

  const StickerSheet({super.key, required this.onStickerSelected});

  static const List<Map<String, String>> stickers = [
    {'emoji': '⭐', 'label': 'Star'},
    {'emoji': '❤️', 'label': 'Heart'},
    {'emoji': '👑', 'label': 'Crown'},
    {'emoji': '🌸', 'label': 'Flower'},
    {'emoji': '🐾', 'label': 'Paw'},
    {'emoji': '🌈', 'label': 'Rainbow'},
    {'emoji': '☀️', 'label': 'Sun'},
    {'emoji': '🚀', 'label': 'Rocket'},
    {'emoji': '🦋', 'label': 'Butterfly'},
    {'emoji': '🍀', 'label': 'Lucky'},
    {'emoji': '🍭', 'label': 'Lollipop'},
    {'emoji': '✨', 'label': 'Sparkles'},
    {'emoji': '🍕', 'label': 'Pizza'},
    {'emoji': '🍩', 'label': 'Donut'},
    {'emoji': '🦄', 'label': 'Unicorn'},
    {'emoji': '🎈', 'label': 'Balloon'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFEEB),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('✨', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Text(
                'Choose a Fun Stamp!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF363A18),
                ),
              ),
              SizedBox(width: 8),
              Text('✨', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Pick a sticker and tap on your canvas to place it!',
            style: TextStyle(color: Color(0xFF776300), fontSize: 14),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: stickers.map((item) {
              final emoji = item['emoji']!;
              return BouncyButton(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                borderWidth: 2,
                borderColor: const Color(0xFFFFD709),
                borderRadius: BorderRadius.circular(20),
                onPressed: () {
                  onStickerSelected(emoji);
                  Navigator.pop(context);
                },
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 36),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
