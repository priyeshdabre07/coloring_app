import 'package:flutter/material.dart';
import 'models/saved_artwork.dart';
import 'services/gallery_service.dart';
import 'widgets/bouncy_button.dart';

class GalleryScreen extends StatelessWidget {
  final VoidCallback onStartNewDrawing;

  const GalleryScreen({super.key, required this.onStartNewDrawing});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GalleryService(),
      builder: (context, _) {
        final artworks = GalleryService().artworks;

        return Scaffold(
          backgroundColor: const Color(0xFFFDFDD9),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFDFDD9),
            elevation: 0,
            title: const Row(
              children: [
                Text('🖼️', style: TextStyle(fontSize: 26)),
                SizedBox(width: 8),
                Text(
                  'My Masterpieces',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF776300),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          body: artworks.isEmpty
              ? _buildEmptyState(context)
              : _buildGalleryGrid(context, artworks),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD709).withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFD709), width: 4),
              ),
              child: const Center(
                child: Text('🎨', style: TextStyle(fontSize: 64)),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Masterpieces Yet!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF363A18),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Color a drawing and tap "Done" to display your awesome artwork here!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF776300),
              ),
            ),
            const SizedBox(height: 32),
            BouncyButton(
              color: const Color(0xFFFFD709),
              borderWidth: 2,
              borderColor: const Color(0xFF776300),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              onPressed: onStartNewDrawing,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.brush, color: Color(0xFF5B4B00)),
                  SizedBox(width: 8),
                  Text(
                    'Color Something Fun! 🚀',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B4B00),
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

  Widget _buildGalleryGrid(BuildContext context, List<SavedArtwork> artworks) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
        childAspectRatio: 0.85,
      ),
      itemCount: artworks.length,
      itemBuilder: (context, index) {
        final art = artworks[index];
        return _buildArtworkCard(context, art);
      },
    );
  }

  Widget _buildArtworkCard(BuildContext context, SavedArtwork art) {
    return GestureDetector(
      onTap: () => _showFullArtworkDialog(context, art),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFFD709), width: 5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Frame picture area
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                child: art.imageBytes != null
                    ? Image.memory(
                        art.imageBytes!,
                        fit: BoxFit.contain,
                      )
                    : Container(
                        color: const Color(0xFFFFFEEB),
                        child: const Center(
                          child: Text('🎨', style: TextStyle(fontSize: 40)),
                        ),
                      ),
              ),
            ),
            // Caption bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFEEB),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(19)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      art.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF363A18),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Text('⭐', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullArtworkDialog(BuildContext context, SavedArtwork art) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: const Color(0xFFFFFEEB),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      art.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF776300),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      GalleryService().deleteArtwork(art.id);
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                constraints: const BoxConstraints(maxHeight: 350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFD709), width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: art.imageBytes != null
                      ? Image.memory(art.imageBytes!, fit: BoxFit.contain)
                      : const Center(child: Text('🎨', style: TextStyle(fontSize: 64))),
                ),
              ),
              const SizedBox(height: 20),
              BouncyButton(
                color: const Color(0xFFFFD709),
                onPressed: () => Navigator.pop(ctx),
                child: const Text(
                  'Close',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B4B00)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
