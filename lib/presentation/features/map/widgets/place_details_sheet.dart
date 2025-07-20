import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';

import '../../../shared/widgets/CustomTextField.dart';

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
                                    place['name'],
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
                                            place['hours'],
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
                                            place['phone'],
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
                                  Text(
                                    place['address'],
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

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
                      ],
                    ),


                    SizedBox(height: AppSpacing.space16(context)),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: onCall,
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
                            onPressed: onGetDirections,
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

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSecondary,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: CustomTextField(hintText: "Opticien")),
                        ),
                        SizedBox(width: AppSpacing.space8(context)),
                        Container(
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
                      SizedBox(height: AppSpacing.space16(context)),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (place['medications'] as List<String>).map((med) =>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                med,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
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
}