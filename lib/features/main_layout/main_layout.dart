import 'package:flutter/material.dart';
import 'package:sturmer/core/navigation/navigation_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      // bottomNavigationBar: const CostumNavigationBar(),
    );
  }
}
