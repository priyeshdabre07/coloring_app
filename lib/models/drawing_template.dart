import 'package:flutter/material.dart';

enum TemplateCategory {
  all,
  animals,
  space,
  ocean,
  fantasy,
}

class DrawingTemplate {
  final String id;
  final String title;
  final String subtitle;
  final TemplateCategory category;
  final String difficulty; // Easy, Fun, Super Star
  final String iconEmoji;
  final Color accentColor;
  final bool isDailyChallenge;
  final bool isBlankCanvas;

  const DrawingTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.difficulty,
    required this.iconEmoji,
    required this.accentColor,
    this.isDailyChallenge = false,
    this.isBlankCanvas = false,
  });

  static const List<DrawingTemplate> allTemplates = [
    DrawingTemplate(
      id: 'lion',
      title: 'Mighty Lion',
      subtitle: 'King of the jungle with a golden mane!',
      category: TemplateCategory.animals,
      difficulty: 'Super Star ⭐',
      iconEmoji: '🦁',
      accentColor: Color(0xFFFFB300),
      isDailyChallenge: true,
    ),
    DrawingTemplate(
      id: 'elephant',
      title: 'Gentle Elephant',
      subtitle: 'Big floppy ears and a playful curved trunk!',
      category: TemplateCategory.animals,
      difficulty: 'Easy 🟢',
      iconEmoji: '🐘',
      accentColor: Color(0xFF64B5F6),
    ),
    DrawingTemplate(
      id: 'giraffe',
      title: 'Tall Giraffe',
      subtitle: 'Reach high for green leaves in the tree tops!',
      category: TemplateCategory.animals,
      difficulty: 'Fun 🟡',
      iconEmoji: '🦒',
      accentColor: Color(0xFFFFD54F),
    ),
    DrawingTemplate(
      id: 'puppy',
      title: 'Playful Puppy',
      subtitle: 'Happy tail wags and floppy ears!',
      category: TemplateCategory.animals,
      difficulty: 'Easy 🟢',
      iconEmoji: '🐶',
      accentColor: Color(0xFFFF8A65),
    ),
    DrawingTemplate(
      id: 'kitten',
      title: 'Cute Kitten',
      subtitle: 'Sweet little whiskers and cozy paws!',
      category: TemplateCategory.animals,
      difficulty: 'Easy 🟢',
      iconEmoji: '🐱',
      accentColor: Color(0xFFBA68C8),
    ),
    DrawingTemplate(
      id: 'rocket',
      title: 'Cosmic Rocket',
      subtitle: 'Blast off to distant stars and planets!',
      category: TemplateCategory.space,
      difficulty: 'Fun 🟡',
      iconEmoji: '🚀',
      accentColor: Color(0xFF4FC3F7),
    ),
    DrawingTemplate(
      id: 'alien',
      title: 'Friendly Alien',
      subtitle: 'Beep boop! A cute visitor from outer space!',
      category: TemplateCategory.space,
      difficulty: 'Easy 🟢',
      iconEmoji: '👾',
      accentColor: Color(0xFF81C784),
    ),
    DrawingTemplate(
      id: 'dolphin',
      title: 'Smiling Dolphin',
      subtitle: 'Splash through sparkling ocean waves!',
      category: TemplateCategory.ocean,
      difficulty: 'Fun 🟡',
      iconEmoji: '🐬',
      accentColor: Color(0xFF00B0FF),
    ),
    DrawingTemplate(
      id: 'turtle',
      title: 'Sea Turtle',
      subtitle: 'Gentle ocean swimmer with a patterned shell!',
      category: TemplateCategory.ocean,
      difficulty: 'Fun 🟡',
      iconEmoji: '🐢',
      accentColor: Color(0xFF4DB6AC),
    ),
    DrawingTemplate(
      id: 'dino',
      title: 'Baby Dino',
      subtitle: 'Friendly little dino having an adventure!',
      category: TemplateCategory.fantasy,
      difficulty: 'Easy 🟢',
      iconEmoji: '🦖',
      accentColor: Color(0xFFAED581),
    ),
    DrawingTemplate(
      id: 'butterfly',
      title: 'Magic Butterfly',
      subtitle: 'Sparkling wings dancing in sunny flower fields!',
      category: TemplateCategory.fantasy,
      difficulty: 'Super Star ⭐',
      iconEmoji: '🦋',
      accentColor: Color(0xFFFF4081),
    ),
    DrawingTemplate(
      id: 'rainbow',
      title: 'Rainbow & Clouds',
      subtitle: 'Bright sunny rays and a magical sky rainbow!',
      category: TemplateCategory.fantasy,
      difficulty: 'Easy 🟢',
      iconEmoji: '🌈',
      accentColor: Color(0xFFFF7043),
    ),
    DrawingTemplate(
      id: 'blank',
      title: 'Blank Canvas',
      subtitle: 'Free doodle space! Draw whatever your imagination dreams up!',
      category: TemplateCategory.all,
      difficulty: 'Open 🎨',
      iconEmoji: '🎨',
      accentColor: Color(0xFFFFD709),
      isBlankCanvas: true,
    ),
  ];
}
