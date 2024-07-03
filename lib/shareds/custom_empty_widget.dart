import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/app_icons.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(),
        Image.asset(AppIcons.empty, height: 120),
        const SizedBox(height: 10),
        const Text('No items have been found', style: TextStyle(fontSize: 24)),
      ],
    );
  }
}
