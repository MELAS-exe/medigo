import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medigo/presentation/features/auth/screens/auth_screen.dart';
import 'package:medigo/presentation/features/auth/view_models/auth_view_models.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          theme: AppTheme.build(context),
          home: AuthScreen(),
        ),
      ),
    ),
  );
}