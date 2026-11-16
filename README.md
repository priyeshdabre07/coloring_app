# Coloring App

A playful Flutter coloring app designed for kids and families. It includes a colorful home dashboard, themed drawing templates, a painting canvas with brushes and stickers, and a saved gallery for completed masterpieces.

## Features

- Kid-friendly home screen with a daily challenge and quick-start actions
- Category-based drawing selection for animals, space, ocean, and fantasy themes
- Drawing tools including:
  - brush
  - rainbow magic brush
  - eraser
  - sticker stamping
  - brush size control
- Undo, redo, and clear-canvas actions
- Save completed artwork to a local gallery
- View, delete, and revisit saved masterpieces
- Bright, cheerful visual design with playful UI styling and animations

## Included templates

The app includes themed pages such as:

- Mighty Lion
- Gentle Elephant
- Tall Giraffe
- Playful Puppy
- Cute Kitten
- Cosmic Rocket
- Friendly Alien
- Smiling Dolphin
- Sea Turtle
- Baby Dino
- Magic Butterfly
- Rainbow & Clouds
- Blank Canvas for freeform doodling

## Tech stack

- Flutter
- Dart
- Material Design
- perfect_freehand for expressive drawing strokes
- confetti for celebration moments
- google_fonts for typography

## Project structure

- lib/main.dart — app entry point
- lib/home_screen.dart — main dashboard and navigation
- lib/pick_a_drawing_screen.dart — template gallery and category filters
- lib/canvas_screen.dart — drawing surface and tool system
- lib/gallery_screen.dart — saved artwork gallery
- lib/models/ — app data models
- lib/services/gallery_service.dart — persistent artwork storage logic
- lib/widgets/ — reusable UI components
- lib/theme/ — color and theme definitions

## Getting started

### Prerequisites

Make sure you have Flutter installed and configured on your machine.

- Flutter SDK: https://docs.flutter.dev/get-started/install
- Android Studio / Xcode for platform emulators if needed

### Install dependencies

From the project root, run:

flutter pub get

### Run the app

For a simulator or connected device:

flutter run

If you want to run on a specific device:

flutter devices
flutter run -d <device-id>

## Common development commands

- Run tests:
  flutter test

- Analyze the project:
  flutter analyze

- Build for Android:
  flutter build apk

- Build for iOS:
  flutter build ios

## Usage

1. Open the app on your device or emulator.
2. Tap a drawing from the home screen or the drawing selection screen.
3. Color the template using the brush, rainbow brush, eraser, or stickers.
4. Adjust brush size and switch between tools from the left tool dock.
5. Tap Done to save your artwork and celebrate your masterpiece.
6. View your saved creations in the My Masterpieces gallery.

## Notes

- The app stores saved artwork locally in the app environment for quick reuse.
- The visual style is intentionally bright and kid-friendly, with large controls and clear actions.
- This project is well suited for extension with sound effects, more drawing categories, or async cloud saving in the future.

## License

This project is currently unlicensed unless you add a license file for distribution or publishing.
