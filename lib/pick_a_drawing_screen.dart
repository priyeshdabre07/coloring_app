import 'package:flutter/material.dart';
import 'canvas_screen.dart';
import 'models/drawing_template.dart';
import 'painters/template_painters.dart';
import 'widgets/bouncy_button.dart';

class PickADrawingScreen extends StatefulWidget {
  final TemplateCategory initialCategory;

  const PickADrawingScreen({
    super.key,
    this.initialCategory = TemplateCategory.all,
  });

  @override
  State<PickADrawingScreen> createState() => _PickADrawingScreenState();
}

class _PickADrawingScreenState extends State<PickADrawingScreen> {
  late TemplateCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  List<DrawingTemplate> get _filteredTemplates {
    if (_selectedCategory == TemplateCategory.all) {
      return DrawingTemplate.allTemplates;
    }
    return DrawingTemplate.allTemplates
        .where((t) => t.category == _selectedCategory || t.isBlankCanvas)
        .toList();
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
                      const Text(
                        'Pick a Drawing! 🎨',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF776300),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD709).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_filteredTemplates.length} pages',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B4B00),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Category Filter Chips
          _buildCategoryChips(),
          const SizedBox(height: 12),

          // Template Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 700 ? 3 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: _filteredTemplates.length,
                  itemBuilder: (context, index) {
                    final template = _filteredTemplates[index];
                    return _buildTemplateCard(context, template);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      {'category': TemplateCategory.all, 'label': '🌟 All'},
      {'category': TemplateCategory.animals, 'label': '🦁 Animals'},
      {'category': TemplateCategory.space, 'label': '🚀 Space'},
      {'category': TemplateCategory.ocean, 'label': '🐬 Ocean'},
      {'category': TemplateCategory.fantasy, 'label': '🦖 Fantasy'},
    ];

    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index]['category'] as TemplateCategory;
          final label = categories[index]['label'] as String;
          final isSelected = _selectedCategory == cat;

          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFD709) : const Color(0xFFFFFEEB),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF776300) : Colors.black12,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFFD709).withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF363A18),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, DrawingTemplate template) {
    return GestureDetector(
      onTap: () => _openCanvas(context, template),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: template.isDailyChallenge
                ? const Color(0xFFFFD709)
                : const Color(0xFFFFE082),
            width: template.isDailyChallenge ? 4 : 2,
          ),
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
            // Header Badge
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: template.accentColor.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        template.difficulty,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF363A18),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (template.isDailyChallenge) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5252),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Daily 🔥',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Vector Outline Preview
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: template.isBlankCanvas
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('✏️', style: TextStyle(fontSize: 48)),
                            SizedBox(height: 6),
                            Text(
                              'Free Draw',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF776300),
                              ),
                            ),
                          ],
                        )
                      : AspectRatio(
                          aspectRatio: 1.0,
                          child: TemplateOutlineWidget(
                            templateId: template.id,
                            strokeWidth: 3.5,
                          ),
                        ),
                ),
              ),
            ),

            // Title & Bouncy Action Button
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFEEB),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Text(
                    template.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color(0xFF363A18),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  BouncyButton(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFFFFD709),
                    borderWidth: 1.5,
                    borderColor: const Color(0xFF776300),
                    borderRadius: BorderRadius.circular(16),
                    elevation: 2,
                    onPressed: () => _openCanvas(context, template),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.brush, size: 16, color: Color(0xFF5B4B00)),
                          SizedBox(width: 4),
                          Text(
                            'Color Me!',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              color: Color(0xFF5B4B00),
                            ),
                          ),
                        ],
                      ),
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

  void _openCanvas(BuildContext context, DrawingTemplate template) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CanvasScreen(template: template),
      ),
    );
  }
}
