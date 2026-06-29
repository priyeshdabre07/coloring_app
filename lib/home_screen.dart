import 'package:flutter/material.dart';

import 'pick_a_drawing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: color.surface,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: color.onSurface.withOpacity(0.06),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Material(
                        color: color.surfaceContainerHighest,
                        shape: const CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.home, color: color.primary),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Art Studio',
                        style: textTheme.headlineMedium?.copyWith(
                          color: color.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: color.surfaceContainerHighest,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: Icon(Icons.settings, color: color.primary),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
        children: [
          // Daily Challenge Hero Section
          Container(
            decoration: BoxDecoration(
              color: color.primaryContainer,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: color.primary.withOpacity(0.3),
                  blurRadius: 50,
                  offset: const Offset(0, 20),
                ),
              ],
              border: Border(
                bottom: BorderSide(
                  color: color.primary.withOpacity(0.1),
                  width: 8,
                ),
              ),
            ),
            padding: const EdgeInsets.all(32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return Flex(
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Text(
                              'Daily Challenge',
                              style: textTheme.labelLarge?.copyWith(
                                color: color.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Roar! Color the Mighty Lion',
                            style: textTheme.displaySmall?.copyWith(
                              color: color.onPrimaryContainer,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Grab your sun-yellow crayons and give our king of the jungle a magnificent golden mane!',
                            style: textTheme.bodyLarge?.copyWith(
                              color: color.onPrimaryContainer.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color.onPrimaryContainer,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              shadowColor: Colors.black.withOpacity(0.2),
                              elevation: 8,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PickADrawingScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.brush),
                            label: Text(
                              'Start Painting',
                              style: textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isWide)
                      const SizedBox(width: 32)
                    else
                      const SizedBox(height: 32),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuB3mPbubOdiMDh99Th_eVFZhup_sYob0GMoQYEGwi_8QZ4wHPGvuuRM0hgrjOvWNTnXMPp-oq40wpEftXS-BBLcxG9E5Er7ZLIVggyzH4gSkGKxIBpEN17m90hJdHoiGpIsIOZne-B9jjGW-i5gVI-p2Kg2rRdFjdKqDkH8omvTCb_1g2DF3zc02y_hUom43iTAITM20d46GvgcajVKdjYRNO3XGRR4ZGHr6zmEe6DVVYWnZMMHzwXDE720-6GQXJ2bF9c6ysRLbBo',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          // ... (Categories, Gallery, BottomNav, FAB to be added)
        ],
      ),
      // ... (BottomNavBar and FAB to be added)
    );
  }
}
