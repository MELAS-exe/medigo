import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medigo/core/theme/spacing.dart';

class PageViewElement extends StatelessWidget {
  final String imagePath;
  final String text;

  PageViewElement({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 375;
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 400,),
            SizedBox(height: AppSpacing.space16(context),),
            SizedBox(
                width: 300*scaleFactor,
                child: Text(text, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }
}