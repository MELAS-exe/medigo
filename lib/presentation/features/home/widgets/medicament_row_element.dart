import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/spacing.dart';

class MedicamentRowElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppSpacing.space8(context)),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/pill.png", height: 24,),
          ),
          SizedBox(height: AppSpacing.space8(context),),
          Text("Soclav", style: Theme.of(context).textTheme.bodySmall),
          Text(
            "1 par jour",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
