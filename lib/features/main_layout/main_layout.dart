import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sturmer/core/navigation/drawer.dart';
import 'package:sturmer/core/navigation/navigation_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key, required this.navigationShell}) : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Stürmer',
                style: TextStyle(
                    fontFamily: 'Germania One',
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(width: 10),
              Icon(Icons.sports_handball_outlined),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                displayDrawer(context);
              },
            );
          }),
        ],
      ),
      endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: const ListDrawer()),
      body: SizedBox.expand(
        child: widget.navigationShell,
      ),
      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}
