import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Map background placeholder
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  'Map View\n(Integration with map service needed)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),

            // Header
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pousser pour naviguer',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(Icons.menu, size: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom section with nearby facilities
            Positioned(
              bottom: 120, // Account for navigation bar
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_hospital,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          SizedBox(width: AppSpacing.space16(context)),
                          Text(
                            'Hôpital',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Spacer(),
                          Icon(
                            Icons.local_pharmacy,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          SizedBox(width: AppSpacing.space8(context)),
                          Text(
                            'Pharmacie',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Spacer(),
                          Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          SizedBox(width: AppSpacing.space8(context)),
                          Text(
                            'Chercher',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}