import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/logo-medigo.png",
                        height: 48,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.medical_services, size: 48, color: Theme.of(context).colorScheme.primary),
                      ),
                      SizedBox(width: AppSpacing.space16(context)),
                      Text(
                        "Medigo",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Icon(Icons.menu, size: 24),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Treatments in progress section
              Text(
                "Traitements en cours",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.space16(context)),

              Row(
                children: [
                  // Add treatment button
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: AppSpacing.space16(context)),

                  // Treatment pills
                  ...List.generate(4, (index) => Container(
                    margin: EdgeInsets.only(right: AppSpacing.space8(context)),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.medication, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Soclav",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "1 par jour",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Prescription section
              Text(
                "Ordonnance",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.space16(context)),

              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: AppSpacing.space16(context)),
                  Expanded(
                    child: Text(
                      "Retrouvez la structure contenant vos médicaments",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  // Doctor illustration placeholder
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Scheduled consultations
              Text(
                "Consultations planifiées",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.space16(context)),

              // Calendar widget
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Month navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.chevron_left),
                        Text(
                          "Avril",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                    SizedBox(height: AppSpacing.space16(context)),

                    // Days of week
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim']
                          .map((day) => Text(
                        day,
                        style: Theme.of(context).textTheme.bodySmall,
                      ))
                          .toList(),
                    ),
                    SizedBox(height: AppSpacing.space8(context)),

                    // Calendar grid (simplified)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1,
                      ),
                      itemCount: 35,
                      itemBuilder: (context, index) {
                        int day = index - 6; // Adjust for month start
                        bool isToday = day == 6;
                        bool isValidDay = day > 0 && day <= 30;

                        return Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isToday ? Theme.of(context).colorScheme.primary : null,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isValidDay
                                ? Text(
                              day.toString(),
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black,
                              ),
                            )
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100), // Space for navigation bar
            ],
          ),
        ),
      ),
    );
  }
}