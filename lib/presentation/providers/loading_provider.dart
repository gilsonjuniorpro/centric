import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends StateNotifier<int> {
  LoadingNotifier() : super(0); // Initial count is 0 (no active requests)

  void startLoading() {
    state = state + 1; // Increment when a request starts
  }

  void stopLoading() {
    if (state > 0) {
      state = state - 1; // Decrement when a request completes
    }
  }
}

final loadingProvider = StateNotifierProvider<LoadingNotifier, int>((ref) {
  return LoadingNotifier();
});
