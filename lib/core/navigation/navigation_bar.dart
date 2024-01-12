import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sturmer/features/main_layout/main_layout_controller.dart';
import 'package:sturmer/theme/pallete.dart';

class CustomNavigationbar extends ConsumerStatefulWidget {
  const CustomNavigationbar({
    super.key,
  });

  @override
  ConsumerState<CustomNavigationbar> createState() => _CustomNavigationbar();
}

class _CustomNavigationbar extends ConsumerState<CustomNavigationbar> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    final position = ref.watch(mainLayoutControllerProvider);
    return CupertinoTabBar(
      // backgroundColor: Theme.of(context).colorScheme.background,
      currentIndex: position,
      onTap: (index) => {
        _onTap(index, context, ref, nameController, descriptionController,
            imageController),
      },
      // backgroundColor: currentTheme.navigationBarTheme.backgroundColor,
      activeColor: currentTheme.dividerColor,
      inactiveColor: currentTheme.hintColor,
      height: 60,
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 8.0), // Add top padding here
            child: Icon(
              Icons.sports_handball,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 8.0), // Add top padding here
            child: Icon(
              Icons.emoji_events_sharp,
            ),
          ),
          label: 'Leagues',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 8.0), // Add top padding here
            child: Icon(
              Icons.star,
            ),
          ),
          label: 'Favorites',
        ),
      ],
    );
  }

  void _onTap(
    int index,
    BuildContext context,
    WidgetRef ref,
    TextEditingController nameController,
    TextEditingController descriptionController,
    TextEditingController imageController,
  ) {
    ref.read(mainLayoutControllerProvider.notifier).setPosition(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/leagues');
        break;
      case 2:
        GoRouter.of(context).go('/favorite');
        break;
      // case 3:
      //   GoRouter.of(context).go('/boards');
      //   break;
      // case 4:
      //   GoRouter.of(context).go('/profile');
      //   break;
      default:
        GoRouter.of(context).go('/home');
    }
    // navigateToScreen(index, context);
  }
}
