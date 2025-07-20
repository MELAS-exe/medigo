// File: lib/presentation/features/map/widgets/place_details_sheet.dart
import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';

import '../screens/drug_search_results_screen.dart';

class PlaceDetailsSheet extends StatefulWidget {
  final Map<String, dynamic> place;
  final VoidCallback onClose;
  final VoidCallback onGetDirections;
  final VoidCallback onCall;

  const PlaceDetailsSheet({
    Key? key,
    required this.place,
    required this.onClose,
    required this.onGetDirections,
    required this.onCall,
  }) : super(key: key);

  @override
  _PlaceDetailsSheetState createState() => _PlaceDetailsSheetState();
}

class _PlaceDetailsSheetState extends State<PlaceDetailsSheet> {
  final TextEditingController _searchController = TextEditingController();

  void _searchMedication(String query) {
    if (query.trim().isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugSearchResultsScreen(searchQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPharmacy = widget.place['type'] == 'pharmacy';

    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        padding: EdgeInsets.only(bottom: 100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 36),
                    // Header with icon and name
                    Stack(
                      children: [
                        // Close button
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                  Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPharmacy ? Icons.local_pharmacy : Icons.local_hospital,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  size: 60,
                                ),
                              ),
                              SizedBox(height: AppSpacing.space8(context)),
                              Column(
                                children: [
                                  Text(
                                    widget.place['name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.access_time, size: 16, color: Theme.of(context).colorScheme.onSurface),
                                          SizedBox(width: 4),
                                          Text(
                                            widget.place['hours'],
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.phone, size: 16, color: Theme.of(context).colorScheme.onSurface),
                                          SizedBox(width: 4),
                                          Text(
                                            widget.place['phone'],
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on, color: Theme.of(context).colorScheme.onSurface, size: 20),
                                  SizedBox(width: AppSpacing.space8(context)),
                                  Expanded(
                                    child: Text(
                                      widget.place['address'],
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: widget.onClose,
                            child: Container(
                              margin: EdgeInsets.all(16),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSpacing.space16(context)),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onCall,
                            icon: Icon(Icons.phone),
                            label: Text('Appeler'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacing.space16(context)),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onGetDirections,
                            icon: Icon(Icons.directions),
                            label: Text('Itinéraire'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSpacing.space32(context)),

                    // Search bar for medications
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onSubmitted: _searchMedication,
                              decoration: InputDecoration(
                                hintText: "Chercher un médicament...",
                                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).focusColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacing.space8(context)),
                        GestureDetector(
                          onTap: () => _searchMedication(_searchController.text),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSpacing.space32(context)),

                    // Services/Medications with stock status
                    if (isPharmacy && widget.place['medications'] != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'En stock',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.place['hasStock'] == true)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Disponible",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.space16(context)),

                      // Display medications in grid format
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 3,
                        ),
                        itemCount: (widget.place['medications'] as List<String>).length,
                        itemBuilder: (context, index) {
                          final med = (widget.place['medications'] as List<String>)[index];
                          // Simulate stock status based on medication name
                          bool inStock = med.hashCode % 3 != 0; // Random stock status

                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: inStock ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                              border: Border.all(
                                color: inStock ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.medication,
                                  size: 14,
                                  color: inStock ? Colors.green : Colors.red,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    med,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: inStock ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    inStock ? "✓" : "✗",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ] else if (!isPharmacy && widget.place['services'] != null) ...[
                      Text(
                        'Services disponibles',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppSpacing.space8(context)),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (widget.place['services'] as List<String>).map((service) =>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                service,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ).toList(),
                      ),
                    ],

                    SizedBox(height: AppSpacing.space32(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}