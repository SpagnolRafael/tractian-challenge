import 'package:flutter/material.dart';
import 'package:tractian_challenge/screens/home_screen/home_screen.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_screen.dart';
import 'package:tractian_challenge/utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>;
        switch (settings.name) {
          case AppRoutes.assetScreen:
            return MaterialPageRoute(
                builder: (context) => TreeScreen(id: args['id'] as String));
        }

        return null;
      },
      home: const HomeScreen(),
    );
  }
}
