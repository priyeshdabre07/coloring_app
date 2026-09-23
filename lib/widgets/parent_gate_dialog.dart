import 'dart:math';
import 'package:flutter/material.dart';
import '../services/gallery_service.dart';
import 'bouncy_button.dart';

class ParentGateDialog extends StatefulWidget {
  const ParentGateDialog({super.key});

  @override
  State<ParentGateDialog> createState() => _ParentGateDialogState();
}

class _ParentGateDialogState extends State<ParentGateDialog> {
  late int num1;
  late int num2;
  late int expectedAnswer;
  final TextEditingController _answerController = TextEditingController();
  bool _isUnlocked = false;
  String? _error;
  bool _soundEnabled = true;

  @override
  void initState() {
    super.initState();
    final random = Random();
    num1 = random.nextInt(6) + 3; // 3 to 8
    num2 = random.nextInt(6) + 2; // 2 to 7
    expectedAnswer = num1 + num2;
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _verifyAnswer() {
    final text = _answerController.text.trim();
    if (int.tryParse(text) == expectedAnswer) {
      setState(() {
        _isUnlocked = true;
        _error = null;
      });
    } else {
      setState(() {
        _error = 'Oops, try again!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: const Color(0xFFFFFEEB),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _isUnlocked ? _buildSettingsPanel() : _buildGatePrompt(),
      ),
    );
  }

  Widget _buildGatePrompt() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          children: [
            Text('🔒', style: TextStyle(fontSize: 28)),
            SizedBox(width: 8),
            Text(
              'Grown-ups Only',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF363A18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Please ask a parent to answer the question to unlock Art Studio settings:',
          style: TextStyle(color: Color(0xFF776300), fontSize: 14),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD709).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFD709), width: 2),
          ),
          child: Text(
            '$num1 + $num2 = ?',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF363A18),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _answerController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'Enter answer',
            errorText: _error,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFFFD709)),
            ),
          ),
          onSubmitted: (_) => _verifyAnswer(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(width: 8),
            BouncyButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: const Color(0xFFFFD709),
              onPressed: _verifyAnswer,
              child: const Text(
                'Unlock',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF363A18)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text('⚙️', style: TextStyle(fontSize: 26)),
                SizedBox(width: 8),
                Text(
                  'Parent Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF363A18),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('Sound Effects & Music', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Play cheerful sounds during drawing'),
          value: _soundEnabled,
          activeTrackColor: const Color(0xFFFFD709),
          onChanged: (val) => setState(() => _soundEnabled = val),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Clear Saved Masterpieces', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          subtitle: const Text('Delete all artwork saved in My Gallery'),
          trailing: const Icon(Icons.delete_forever, color: Colors.red),
          onTap: () {
            GalleryService().clearAll();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gallery cleared!')),
            );
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Kids Art Studio v1.0 • Designed for young artists',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
