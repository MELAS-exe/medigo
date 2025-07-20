import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/presentation/shared/widgets/custom_button.dart';
import 'dart:io';

class PrescriptionResultsScreen extends StatelessWidget {
  final String imagePath;
  final List<String> medications;

  const PrescriptionResultsScreen({
    Key? key,
    required this.imagePath,
    required this.medications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Médicaments détectés'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.space16(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image preview
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: AppSpacing.space32(context)),

            // Results header
            Row(
              children: [
                Icon(
                  Icons.medication,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
                SizedBox(width: AppSpacing.space8(context)),
                Text(
                  'Médicaments identifiés',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.space16(context)),

            // Medications list
            if (medications.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.space16(context)),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 48,
                    ),
                    SizedBox(height: AppSpacing.space8(context)),
                    Text(
                      'Aucun médicament détecté',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSpacing.space4(context)),
                    Text(
                      'Veuillez reprendre une photo plus claire de votre ordonnance',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.orange[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...medications.asMap().entries.map((entry) {
                final index = entry.key;
                final medication = entry.value;

                return Container(
                  margin: EdgeInsets.only(bottom: AppSpacing.space8(context)),
                  padding: EdgeInsets.all(AppSpacing.space16(context)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.space16(context)),
                      Expanded(
                        child: Text(
                          medication.replaceAll(RegExp(r'^\d+\.\s*'), ''), // Remove numbering if present
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.medication_liquid,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                    ],
                  ),
                );
              }).toList(),

            SizedBox(height: AppSpacing.space32(context)),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Reprendre',
                    backgroundColor: Colors.grey[600],
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: AppSpacing.space16(context)),
                Expanded(
                  child: CustomButton(
                    text: 'Rechercher',
                    onTap: () {
                      if (medications.isNotEmpty) {
                        _navigateToSearch(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Aucun médicament à rechercher'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.space16(context)),

            // Info box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppSpacing.space16(context)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.space8(context)),
                  Expanded(
                    child: Text(
                      'Vous pouvez maintenant rechercher ces médicaments dans les pharmacies proches de vous.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSearch(BuildContext context) {
    // Navigate to pharmacy search with medications
    // You can implement this based on your app's navigation structure
    Navigator.popUntil(context, (route) => route.isFirst);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recherche des médicaments dans les pharmacies...'),
        backgroundColor: Colors.green,
      ),
    );
  }
}