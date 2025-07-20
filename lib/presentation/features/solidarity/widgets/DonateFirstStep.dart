import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medigo/presentation/features/camera/screens/camera_screen.dart';

import '../../../../core/theme/spacing.dart';
import '../../../shared/widgets/custom_button.dart';

class DonateFirstStep extends StatefulWidget {
  @override
  State<DonateFirstStep> createState() => _DonateFirstStepState();
}

class _DonateFirstStepState extends State<DonateFirstStep> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSpacing.space32(context)),
            Text(
              "Scannez votre ordonnance\net nous allons lancer une\ncampagne",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.space32(context)),
            CustomButton(
              text: "Scanner",
              width: double.infinity,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CameraScreen();
                }));
              },
            ),
            SizedBox(height: AppSpacing.space16(context)),
          ],
        ),
      ),
    );
  }
}