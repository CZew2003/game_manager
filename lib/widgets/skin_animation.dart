import 'package:flutter/material.dart';

class SkinAnimation extends StatelessWidget {
  const SkinAnimation({
    super.key,
    required this.isLoading,
    required this.skinPath,
  });

  final bool isLoading;
  final String skinPath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(builder: (BuildContext context) {
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Image.asset(
            'assets/skins/$skinPath',
            key: ValueKey<String>(skinPath),
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }
}
