import 'package:flutter/material.dart';

import 'canvas_screen.dart';

class PickADrawingScreen extends StatelessWidget {
  const PickADrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example animal data
    final animals = [
      {
        'title': 'Gentle Elephant',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDRPWcAie3HW5FbSF3bHrB2Mj6L-rm5iBNqDjrKYx5d08wM1B7kVL25YYutbtu2Eqd5WAVuyOxFF_Yu4rSeSJVw5t7_Co_7QLCR0uxTxily6fbdzL-RbDUn8kpRYWHnNOhEHuJt9ogFUKfQyueAi8aHki0DpcOxjSv0Z75stDLPDrKj-Q2vdj4DPsbRywm-8HxzsGFEgVqsauXqz2F9L21UUuGdZ6801w3ZdunulRv7Czm6KMmIziwQpDz3WWAjW-16FNLgCwhxM1A',
        'label': 'Popular',
        'featured': true,
      },
      {
        'title': 'Tall Giraffe',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAXvrTzSHX_JNE5vx_V5jlUZOEHeCHPIkgOGsuHjU9kFk88MdsZcEg4tCkxlDzaayuZsnDYTMnobzXNpKsuT43CwHuXvR2wNVRWuxwKNu7tcVQ33ljJ8pfONb0N9U7dn6YznTsLiIXDi3tdZT-x1VGXuLmA6fgeogqQwUXyCI3gJG8O_3RJcmaphZZ4eblJ3m2ZI-sBoYOhOFge3bFuxh1gTwlMNNVCmliusHBWEU4WhtQDlb3PYZssRxR3W0yNm4pNoZu4zIWcZCc',
        'label': null,
        'featured': false,
      },
      // Add more animals...
    ];

    return Scaffold(
      backgroundColor: Color(0xFFFDFFD9), // Use your theme color
      appBar: AppBar(
        backgroundColor: Color(0xFFFDFFD9),
        elevation: 0,
        title: Text(
          'Animals',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF776300),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF776300)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Color(0xFF776300)),
            onPressed: () {},
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick a Friend to Draw!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Select your favorite animal and start coloring.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                itemCount: animals.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust for responsiveness
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final animal = animals[index] as Map<String, dynamic>;
                  final isFeatured = animal['featured'] as bool;
                  final label = animal['label'] as String?;
                  final title = animal['title'] as String;
                  final image = animal['image'] as String;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: isFeatured ? 8 : 2,
                    color: isFeatured ? Color(0xFFF9FEC8) : Colors.white,
                    child: InkWell(
                      onTap: () {
                        // Navigate to drawing screen
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (label != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF9288),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Image.network(image, fit: BoxFit.contain),
                            ),
                            SizedBox(height: 8),
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFD709),
                                foregroundColor: Color(0xFF5B4B00),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CanvasScreen(),
                                  ),
                                );
                              },
                              child: Text('Color Me'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Add your custom BottomNavigationBar here
      // floatingActionButton: ... (for the FAB)
    );
  }
}
