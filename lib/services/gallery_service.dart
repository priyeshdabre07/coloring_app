import 'package:flutter/foundation.dart';
import '../models/saved_artwork.dart';

class GalleryService extends ChangeNotifier {
  static final GalleryService _instance = GalleryService._internal();
  factory GalleryService() => _instance;
  GalleryService._internal();

  final List<SavedArtwork> _artworks = [];

  List<SavedArtwork> get artworks => List.unmodifiable(_artworks);

  bool get isEmpty => _artworks.isEmpty;
  int get count => _artworks.length;

  void saveArtwork(SavedArtwork artwork) {
    // Insert at front so newest is first
    _artworks.insert(0, artwork);
    notifyListeners();
  }

  void deleteArtwork(String id) {
    _artworks.removeWhere((art) => art.id == id);
    notifyListeners();
  }

  void clearAll() {
    _artworks.clear();
    notifyListeners();
  }
}
