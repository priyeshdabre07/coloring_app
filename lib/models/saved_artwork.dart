import 'dart:typed_data';

class SavedArtwork {
  final String id;
  final String title;
  final String templateId;
  final DateTime date;
  final Uint8List? imageBytes;
  final int strokesCount;
  final int stickersCount;

  const SavedArtwork({
    required this.id,
    required this.title,
    required this.templateId,
    required this.date,
    this.imageBytes,
    this.strokesCount = 0,
    this.stickersCount = 0,
  });
}
