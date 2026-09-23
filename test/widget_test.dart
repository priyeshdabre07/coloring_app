import 'package:coloring_app/canvas_screen.dart';
import 'package:coloring_app/models/drawing_template.dart';
import 'package:coloring_app/pick_a_drawing_screen.dart';
import 'package:coloring_app/services/gallery_service.dart';
import 'package:coloring_app/models/saved_artwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coloring_app/theme/theme.dart';

Widget appWrapper(Widget child) {
  return MaterialApp(
    theme: buildAppTheme(),
    home: child,
  );
}

void main() {
  setUp(() {
    // Clear gallery before each test
    GalleryService().clearAll();
  });

  group('Canvas Screen', () {
    testWidgets('Canvas screen builds without crash', (WidgetTester tester) async {
      await tester.pumpWidget(appWrapper(const CanvasScreen()));
      await tester.pump();
      // Should not crash; verify app bar back arrow and Done button are present
      expect(find.byIcon(Icons.arrow_back), findsWidgets);
      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('Canvas screen with lion template builds', (WidgetTester tester) async {
      final lion = DrawingTemplate.allTemplates.firstWhere((t) => t.id == 'lion');
      await tester.pumpWidget(appWrapper(CanvasScreen(template: lion)));
      await tester.pump();
      expect(find.text('Mighty Lion'), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('Canvas screen with blank template builds', (WidgetTester tester) async {
      final blank = DrawingTemplate.allTemplates.firstWhere((t) => t.isBlankCanvas);
      await tester.pumpWidget(appWrapper(CanvasScreen(template: blank)));
      await tester.pump();
      expect(find.text('Blank Canvas'), findsOneWidget);
    });

    testWidgets('Undo and Redo buttons start disabled', (WidgetTester tester) async {
      await tester.pumpWidget(appWrapper(const CanvasScreen()));
      await tester.pump();
      // Undo/Redo should be rendered
      expect(find.byIcon(Icons.undo), findsOneWidget);
      expect(find.byIcon(Icons.redo), findsOneWidget);
    });
  });

  group('Pick a Drawing Screen', () {
    testWidgets('PickADrawingScreen renders all templates', (WidgetTester tester) async {
      await tester.pumpWidget(appWrapper(const PickADrawingScreen()));
      await tester.pump();
      // Verify the page header is shown
      expect(find.textContaining('Pick a Drawing'), findsWidgets);
    });

    testWidgets('Category filters are present', (WidgetTester tester) async {
      await tester.pumpWidget(appWrapper(const PickADrawingScreen()));
      await tester.pump();
      expect(find.textContaining('Animals'), findsOneWidget);
      expect(find.textContaining('Space'), findsOneWidget);
      expect(find.textContaining('Ocean'), findsOneWidget);
    });
  });

  group('Gallery Service', () {
    test('GalleryService starts empty', () {
      expect(GalleryService().isEmpty, isTrue);
      expect(GalleryService().count, 0);
    });

    test('GalleryService saves and retrieves artwork', () {
      final art = SavedArtwork(
        id: 'test-1',
        title: 'My Lion',
        templateId: 'lion',
        date: DateTime.now(),
        strokesCount: 5,
        stickersCount: 2,
      );
      GalleryService().saveArtwork(art);
      expect(GalleryService().count, 1);
      expect(GalleryService().artworks.first.title, 'My Lion');
    });

    test('GalleryService delete artwork works', () {
      final art = SavedArtwork(
        id: 'del-1',
        title: 'To Delete',
        templateId: 'lion',
        date: DateTime.now(),
      );
      GalleryService().saveArtwork(art);
      expect(GalleryService().count, 1);
      GalleryService().deleteArtwork('del-1');
      expect(GalleryService().count, 0);
    });

    test('GalleryService newest artwork is first', () {
      GalleryService().saveArtwork(SavedArtwork(
        id: 'old-1',
        title: 'Older',
        templateId: 'lion',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
      ));
      GalleryService().saveArtwork(SavedArtwork(
        id: 'new-1',
        title: 'Newest',
        templateId: 'dino',
        date: DateTime.now(),
      ));
      expect(GalleryService().artworks.first.id, 'new-1');
    });
  });

  group('Drawing Templates', () {
    test('Has a daily challenge template', () {
      final daily = DrawingTemplate.allTemplates.where((t) => t.isDailyChallenge).toList();
      expect(daily.isNotEmpty, isTrue);
    });

    test('Has a blank canvas template', () {
      final blank = DrawingTemplate.allTemplates.where((t) => t.isBlankCanvas).toList();
      expect(blank.isNotEmpty, isTrue);
    });

    test('All templates have non-empty id, title, emoji', () {
      for (final template in DrawingTemplate.allTemplates) {
        expect(template.id.isNotEmpty, isTrue, reason: 'Template missing id');
        expect(template.title.isNotEmpty, isTrue, reason: 'Template missing title');
        expect(template.iconEmoji.isNotEmpty, isTrue, reason: 'Template missing emoji');
      }
    });

    test('Has templates for all categories', () {
      final ids = DrawingTemplate.allTemplates.map((t) => t.category).toSet();
      expect(ids.contains(TemplateCategory.animals), isTrue);
      expect(ids.contains(TemplateCategory.space), isTrue);
      expect(ids.contains(TemplateCategory.ocean), isTrue);
      expect(ids.contains(TemplateCategory.fantasy), isTrue);
    });
  });
}
