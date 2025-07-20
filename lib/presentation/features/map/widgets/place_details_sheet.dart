import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';

class PlaceDetailsSheet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isPharmacy = place['type'] == 'pharmacy';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
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

          // Close button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onClose,
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

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and name
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isPharmacy
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isPharmacy
                              ? Theme.of(context).colorScheme.primary
                              : Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPharmacy ? Icons.local_pharmacy : Icons.local_hospital,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: AppSpacing.space16(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place['name'],
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  place['hours'],
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  place['phone'],
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Stock indicator for pharmacies
                      if (isPharmacy)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: place['hasStock']
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            place['hasStock'] ? 'En stock' : 'Rupture',
                            style: TextStyle(
                              color: place['hasStock'] ? Colors.green : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: AppSpacing.space32(context)),

                // Address
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[600], size: 20),
                    SizedBox(width: AppSpacing.space8(context)),
                    Expanded(
                      child: Text(
                        place['address'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSpacing.space32(context)),

                // Services/Medications
                if (isPharmacy && place['medications'] != null) ...[
                  Text(
                    'Médicaments disponibles',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.space8(context)),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (place['medications'] as List<String>).map((med) =>
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            med,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ).toList(),
                  ),
                ] else if (!isPharmacy && place['services'] != null) ...[
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
                    children: (place['services'] as List<String>).map((service) =>
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

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onCall,
                        icon: Icon(Icons.phone),
                        label: Text('Appeler'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
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
                        onPressed: onGetDirections,
                        icon: Icon(Icons.directions),
                        label: Text('Itinéraire'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}