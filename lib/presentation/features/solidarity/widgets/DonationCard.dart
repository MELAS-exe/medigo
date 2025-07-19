import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/spacing.dart';
import '../../../shared/widgets/custom_button.dart';

class DonationCard extends StatelessWidget {
  final String name;
  final String amount;
  final bool isCompleted;

  const DonationCard({super.key, required this.name, required this.amount, required this.isCompleted});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              amount,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Fcfa",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 16,
                          children: [
                            Column(
                              children: [
                                Image.asset("assets/pill.png", width: 24,),
                                SizedBox(height: 4),
                                Text("Soclav", style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset("assets/pill.png", width: 24,),
                                SizedBox(height: 4),
                                Text("Soclav", style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset("assets/pill.png", width: 24,),
                                SizedBox(height: 4),
                                Text("Soclav", style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset("assets/pill.png", width: 24,),
                                SizedBox(height: 4),
                                Text("Soclav", style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.space8(context)),
                // Progress bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 220*MediaQuery.of(context).size.width/375,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      image: Image.asset("assets/donate.png", width: 12,),
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}