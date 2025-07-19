import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../camera/screens/camera_screen.dart';
import '../widgets/medicament_row_element.dart';

class Home extends StatelessWidget {
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
                        height: 36,
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
                              Icons.medical_services,
                              size: 48,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      SizedBox(width: AppSpacing.space16(context)),
                      Text(
                        "Medigo",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  GestureDetector(child: Icon(Icons.menu, size: 24)),
                ],
              ),

              SizedBox(height: AppSpacing.space32(context)),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Traitements en cours",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: AppSpacing.space8(context)),
                            Text(
                              "Ajouter",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        SizedBox(width: AppSpacing.space16(context)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.57,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 16,
                              children: [
                                MedicamentRowElement(),
                                MedicamentRowElement(),
                                MedicamentRowElement(),
                                MedicamentRowElement(),
                                MedicamentRowElement(),
                                MedicamentRowElement(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Prescription section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ordonnance",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap : (){
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => CameraScreen(),
                                //   ),
                                // );
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(height: AppSpacing.space8(context)),
                            SizedBox(
                              width: 150,
                              child: Text(
                                "Retrouvez la structure contenant vos médicaments",
                                // textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                       Image.asset("assets/scan-hero.png", width: 150,)
                      ],
                    ),
                  ],
                ),
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
                      children:
                          ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim']
                              .map(
                                (day) => Text(
                                  day,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
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
                            color:
                                isToday
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child:
                                isValidDay
                                    ? Text(
                                      day.toString(),
                                      style: TextStyle(
                                        color:
                                            isToday
                                                ? Colors.white
                                                : Colors.black,
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
