import 'package:flutter/material.dart';

class LolBlackLogo extends StatelessWidget {
  const LolBlackLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.07,
        child: Image.asset('assets/images/lol_black_logo.png'),
      ),
    );
  }
}
