import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medigo/presentation/features/auth/widgets/Login.dart';

import '../../../../core/theme/spacing.dart';
import '../../../shared/widgets/CustomTextField.dart';
import '../../../shared/widgets/custom_button.dart';

class Inscription extends StatefulWidget {
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.space16(context)),
        child: Column(
          children: [
            Text(
              "Inscription",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.space64(context)),
            CustomTextField(hintText: "Prénom"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomTextField(hintText: "Nom"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomTextField(hintText: "Téléphone"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomTextField(hintText: "Mot de passe"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomTextField(hintText: "Confirmer mot de passe"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomButton(
              onTap: () {},
              width: MediaQuery.of(context).size.width,
              text: "S'inscrire",
            ),
            SizedBox(height: AppSpacing.space32(context)),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Theme.of(context).focusColor,
            ),
            SizedBox(height: AppSpacing.space32(context)),
            Text(
              "Vous avez déjà un compte?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  isScrollControlled: true,
                  builder:
                      (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SingleChildScrollView(
                          child: Column(children: [Login()]),
                        ),
                      ),
                );
              },
              child: Text(
                "Connectez vous?",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.space32(context)),
          ],
        ),
      ),
    );
  }
}
