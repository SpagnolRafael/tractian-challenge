import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/configs.dart';
import 'package:tractian_challenge/core/injection.dart';
import 'package:tractian_challenge/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup(StagingConfigs());
  runApp(const MyApp());
}
