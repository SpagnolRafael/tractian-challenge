import 'package:flutter/material.dart';
import 'package:tractian_challenge/shareds/custom_appbar.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final void Function()? onBackTap;
  final String? title;
  const CustomScaffold(
      {super.key, required this.body, this.onBackTap, this.title});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(title: widget.title, onBackTap: widget.onBackTap),
            Expanded(child: widget.body),
          ],
        ),
      ),
    );
  }
}
