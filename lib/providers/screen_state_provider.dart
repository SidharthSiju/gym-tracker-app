import 'package:flutter_riverpod/legacy.dart';

class ScreenStateNotifier extends StateNotifier<String> {
  ScreenStateNotifier() : super('home');

  void setScreen(String screen) {
    state = screen;
  }
}

final screenStateProvider = StateNotifierProvider<ScreenStateNotifier, String>((
  ref,
) {
  return ScreenStateNotifier();
});
