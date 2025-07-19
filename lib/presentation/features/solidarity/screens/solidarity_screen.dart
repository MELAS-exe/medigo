import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/presentation/features/solidarity/widgets/DonationCard.dart';
import 'package:medigo/presentation/features/solidarity/widgets/request_card.dart';
import 'package:medigo/presentation/shared/widgets/custom_button.dart';

import '../widgets/DonateFirstStep.dart';

class SolidarityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Faites vous acheter vos médicaments",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppSpacing.space16(context)),
                            CustomButton(
                              text: "Demander",
                              width: 150,
                              height: 48,
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (context) => DonateFirstStep(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        "assets/donation-hero.png",
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // My requests section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mes demandes",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 16,
                        children: [
                          RequestCard(elements: "3 Elements",
                              amount: "30.000",
                              currency: "Fcfa"),
                          RequestCard(elements: "3 Elements",
                              amount: "30.000",
                              currency: "Fcfa"),
                          RequestCard(elements: "3 Elements",
                              amount: "30.000",
                              currency: "Fcfa"),
                          RequestCard(elements: "3 Elements",
                              amount: "30.000",
                              currency: "Fcfa"),
                          RequestCard(elements: "3 Elements",
                              amount: "30.000",
                              currency: "Fcfa"),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Donation section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      "Donation",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                    ),
                    DonationCard(
                      name: "Patar", amount: "230.000", isCompleted: true,),
                    DonationCard(
                        name: "Patar", amount: "230.000", isCompleted: false),
                    DonationCard(
                        name: "Patar", amount: "230.000", isCompleted: false),
                    DonationCard(
                        name: "Patar", amount: "230.000", isCompleted: false),
                    DonationCard(
                        name: "Patar", amount: "230.000", isCompleted: false),
                    DonationCard(
                        name: "Patar", amount: "230.000", isCompleted: false),

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
