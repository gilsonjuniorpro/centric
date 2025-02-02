import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingIndicator extends ConsumerWidget {
  final String message;
  final Color textColor;
  final Color indicatorColor;

  const LoadingIndicator({
    super.key,
    this.message = 'Loading...',
    this.textColor = Colors.blue,
    this.indicatorColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }
}
