import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sturmer/core/navigation/drawer.dart';
import 'package:sturmer/features/leagues/screens/leagues.dart';
import 'package:sturmer/theme/pallete.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height;
    final double itemWidth = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           'Stürmer',
      //           style: TextStyle(
      //               fontFamily: 'Germania One',
      //               fontSize: 30,
      //               fontStyle: FontStyle.italic),
      //         ),
      //         SizedBox(width: 10),
      //         Icon(Icons.sports_handball_outlined),
      //       ],
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: const Icon(Icons.search),
      //     onPressed: () {},
      //   ),
      //   actions: [
      //     Builder(builder: (context) {
      //       return IconButton(
      //         icon: const Icon(Icons.menu),
      //         onPressed: () {
      //           displayDrawer(context);
      //         },
      //       );
      //     }),
      //   ],
      // ),
      endDrawer: const ListDrawer(),
      body: Column(
        children: [
          AppBarExtension(
              currentTheme: currentTheme,
              width: itemWidth,
              title: 'Favorites',
              height: 50)
        ],
      ),
    );
  }
}
