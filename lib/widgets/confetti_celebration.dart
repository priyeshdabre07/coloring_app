import 'dart:typed_data';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'bouncy_button.dart';

class ConfettiCelebrationDialog extends StatefulWidget {
  final String title;
  final Uint8List? imageBytes;
  final VoidCallback onSave;
  final VoidCallback onContinue;

  const ConfettiCelebrationDialog({
    super.key,
    required this.title,
    this.imageBytes,
    required this.onSave,
    required this.onContinue,
  });

  @override
  State<ConfettiCelebrationDialog> createState() =>
      _ConfettiCelebrationDialogState();
}

class _ConfettiCelebrationDialogState extends State<ConfettiCelebrationDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 4));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          backgroundColor: const Color(0xFFFFFEEB),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Trophy / Medal
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD709),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('🏆', style: TextStyle(fontSize: 44)),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1.08, 1.08),
                      duration: 800.ms,
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: 16),
                const Text(
                  'Superstar Artist! 🎉',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF776300),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'You colored ${widget.title} beautifully!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF363A18),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Artwork Preview in Cute Frame
                if (widget.imageBytes != null)
                  Container(
                    width: 220,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFFD709),
                        width: 8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        widget.imageBytes!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFFFD709),
                        width: 4,
                      ),
                    ),
                    child: const Center(
                      child: Text('🎨', style: TextStyle(fontSize: 48)),
                    ),
                  ),

                const SizedBox(height: 28),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BouncyButton(
                      color: Colors.white,
                      borderWidth: 2,
                      borderColor: const Color(0xFF776300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      onPressed: () {
                        widget.onContinue();
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.edit, size: 20, color: Color(0xFF776300)),
                          SizedBox(width: 6),
                          Text(
                            'Keep Drawing',
                            style: TextStyle(
                              color: Color(0xFF776300),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BouncyButton(
                      color: const Color(0xFFFFD709),
                      borderWidth: 2,
                      borderColor: const Color(0xFF776300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      onPressed: () {
                        widget.onSave();
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.save_alt, size: 20, color: Color(0xFF5B4B00)),
                          SizedBox(width: 6),
                          Text(
                            'Save to Gallery ⭐',
                            style: TextStyle(
                              color: Color(0xFF5B4B00),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Confetti Fireworks Blast
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.red,
            Colors.blue,
            Colors.amber,
            Colors.green,
            Colors.purple,
            Colors.pink,
            Colors.orange,
          ],
          numberOfParticles: 40,
          gravity: 0.15,
        ),
      ],
    );
  }
}
