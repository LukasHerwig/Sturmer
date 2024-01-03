import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CostumNavigationBar extends ConsumerStatefulWidget {
  const CostumNavigationBar({super.key});

  @override
  ConsumerState<CostumNavigationBar> createState() =>
      _CostumNavigationBarState();
}

class _CostumNavigationBarState extends ConsumerState<CostumNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
    );
  }
}
