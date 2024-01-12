import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainLayoutControllerProvider =
    StateNotifierProvider<MainLayoutController, int>((ref) {
  return MainLayoutController(0);
});

class MainLayoutController extends StateNotifier<int> {
  MainLayoutController(super.state);

  void setPosition(int value) {
    state = value;
  }
}
