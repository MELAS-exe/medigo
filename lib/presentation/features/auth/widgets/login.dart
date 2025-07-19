import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/presentation/shared/widgets/CustomTextField.dart';
import 'package:medigo/presentation/shared/widgets/custom_button.dart';
import 'package:medigo/presentation/features/auth/widgets/inscription.dart';
import '../../navigation/screens/navigation.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.space16(context)),
        child: Column(
          children: [
            Text(
              "Connexion",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.space64(context)),
            CustomTextField(hintText: "Téléphone"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomTextField(hintText: "Mot de passe"),
            SizedBox(height: AppSpacing.space16(context)),
            CustomButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Navigation();
                }));
              },
              width: MediaQuery.of(context).size.width,
              text: "Se connecter",
            ),
            SizedBox(height: AppSpacing.space32(context)),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Theme.of(context).focusColor,
            ),
            SizedBox(height: AppSpacing.space32(context)),
            Text(
              "Vous n'avez pas de compte?",
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
                          child: Column(children: [Inscription()]),
                        ),
                      ),
                );
              },
              child: Text(
                "Inscrivez vous?",
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
