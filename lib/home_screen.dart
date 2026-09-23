import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'canvas_screen.dart';
import 'gallery_screen.dart';
import 'models/drawing_template.dart';
import 'painters/template_painters.dart';
import 'pick_a_drawing_screen.dart';
import 'services/gallery_service.dart';
import 'widgets/bouncy_button.dart';
import 'widgets/kid_bottom_nav.dart';
import 'widgets/parent_gate_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDD9),
      body: Stack(
        children: [
          // Main Body Content
          IndexedStack(
            index: _currentNavIndex,
            children: [
              _buildHomeDashboard(context),
              const PickADrawingScreen(),
              GalleryScreen(
                onStartNewDrawing: () => setState(() => _currentNavIndex = 1),
              ),
            ],
          ),

          // Floating Kid Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: KidBottomNav(
              currentIndex: _currentNavIndex,
              onIndexChanged: (index) => setState(() => _currentNavIndex = index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeDashboard(BuildContext context) {
    final dailyLion = DrawingTemplate.allTemplates.firstWhere(
      (t) => t.id == 'lion',
      orElse: () => DrawingTemplate.allTemplates.first,
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
        children: [
          // Top Header & Mascot Bar
          _buildMascotHeader(context),
          const SizedBox(height: 20),

          // Daily Challenge Hero Card
          _buildDailyChallengeCard(context, dailyLion),
          const SizedBox(height: 24),

          // Quick Start Doodle Button & Explore Button
          _buildQuickActionButtons(context),
          const SizedBox(height: 28),

          // Browse by Category Section
          _buildCategorySection(context),
          const SizedBox(height: 28),

          // Recent Masterpieces Section
          _buildRecentMasterpiecesSection(context),
        ],
      ),
    );
  }

  Widget _buildMascotHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEEB),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFFFD709), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Mascot Avatar with gentle bounce animation
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFD709),
                ),
                child: const Center(
                  child: Text('🦁', style: TextStyle(fontSize: 28)),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.08, 1.08),
                    duration: 1000.ms,
                  ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Art Studio ✨',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF776300),
                    ),
                  ),
                  Text(
                    'Ready to color today?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF363A18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Grown-ups / Settings Button
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF776300), size: 28),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ParentGateDialog(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallengeCard(BuildContext context, DrawingTemplate template) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD709), Color(0xFFFFB300)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFF776300), width: 3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB300).withValues(alpha: 0.4),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🔥', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 4),
                    Text(
                      'DAILY CHALLENGE',
                      style: TextStyle(
                        color: Color(0xFF776300),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Text('⭐ ⭐ ⭐', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Roar! Mighty Lion',
                      style: const TextStyle(
                        color: Color(0xFF363A18),
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Give our king of the jungle a magnificent golden mane!',
                      style: TextStyle(
                        color: Color(0xFF5B4B00),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    BouncyButton(
                      color: const Color(0xFF363A18),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      elevation: 4,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CanvasScreen(template: template),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.brush, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Start Painting',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Vector Outline Preview of Lion inside circle with gentle float
              Expanded(
                flex: 2,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF776300), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TemplateOutlineWidget(
                      templateId: 'lion',
                      strokeWidth: 3.0,
                    ),
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: -4, end: 4, duration: 1500.ms, curve: Curves.easeInOut),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButtons(BuildContext context) {
    final blankTemplate = DrawingTemplate.allTemplates.firstWhere(
      (t) => t.isBlankCanvas,
      orElse: () => DrawingTemplate.allTemplates.last,
    );

    return Row(
      children: [
        // Free Doodle Pad
        Expanded(
          child: BouncyButton(
            color: const Color(0xFFFFFEEB),
            borderWidth: 2.5,
            borderColor: const Color(0xFFFFD709),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            borderRadius: BorderRadius.circular(24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CanvasScreen(template: blankTemplate),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🎨', style: TextStyle(fontSize: 22)),
                SizedBox(width: 8),
                Text(
                  'Free Doodle Pad',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: Color(0xFF776300),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Explore All
        Expanded(
          child: BouncyButton(
            color: const Color(0xFFFFD709),
            borderWidth: 2.5,
            borderColor: const Color(0xFF776300),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            borderRadius: BorderRadius.circular(24),
            onPressed: () => setState(() => _currentNavIndex = 1),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('📖', style: TextStyle(fontSize: 22)),
                SizedBox(width: 8),
                Text(
                  'Coloring Book',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: Color(0xFF5B4B00),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    final categories = [
      {'name': 'Animals', 'emoji': '🦁', 'cat': TemplateCategory.animals, 'color': const Color(0xFFFFD54F)},
      {'name': 'Space', 'emoji': '🚀', 'cat': TemplateCategory.space, 'color': const Color(0xFF81D4FA)},
      {'name': 'Ocean', 'emoji': '🐬', 'cat': TemplateCategory.ocean, 'color': const Color(0xFF80DEEA)},
      {'name': 'Fantasy', 'emoji': '🦖', 'cat': TemplateCategory.fantasy, 'color': const Color(0xFFA5D6A7)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Explore Categories 🌈',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF776300),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _currentNavIndex = 1),
              child: const Text(
                'See All >',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF776300),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: categories.map((cat) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: BouncyButton(
                  color: cat['color'] as Color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  borderRadius: BorderRadius.circular(20),
                  elevation: 3,
                  borderWidth: 2,
                  borderColor: Colors.black12,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickADrawingScreen(
                          initialCategory: cat['cat'] as TemplateCategory,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(cat['emoji'] as String, style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 6),
                      Text(
                        cat['name'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF363A18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentMasterpiecesSection(BuildContext context) {
    return AnimatedBuilder(
      animation: GalleryService(),
      builder: (context, _) {
        final artworks = GalleryService().artworks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text('🖼️', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 6),
                    Text(
                      'My Masterpieces',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF776300),
                      ),
                    ),
                  ],
                ),
                if (artworks.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _currentNavIndex = 2),
                    child: const Text(
                      'View Gallery >',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF776300),
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            if (artworks.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFEEB),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFFFD709), width: 2),
                ),
                child: Row(
                  children: [
                    const Text('🌟', style: TextStyle(fontSize: 36)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Your Gallery is Ready!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF363A18),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Finish a drawing and tap Done to see it saved right here.',
                            style: TextStyle(fontSize: 13, color: Color(0xFF776300)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: artworks.length,
                  itemBuilder: (context, index) {
                    final art = artworks[index];
                    return Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFFD709), width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: art.imageBytes != null
                            ? Image.memory(art.imageBytes!, fit: BoxFit.contain)
                            : const Center(child: Text('🎨', style: TextStyle(fontSize: 36))),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
