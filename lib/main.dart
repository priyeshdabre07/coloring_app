import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'theme/theme.dart';

void main() => runApp(const ColoringAppRoot());

class ColoringAppRoot extends StatelessWidget {
  const ColoringAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}
