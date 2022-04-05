import 'package:flutter/material.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';

import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class CandlesticksCount extends StatelessWidget {
  const CandlesticksCount({Key? key,required this.number}) : super(key: key);

  final double number;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kAvalancheTokenIcon,
              height: 30,
            ),
            const SizedBox(
              width: 7,
            ),
            const Text(
              PxStrings.countTitleAvax,
              style: textStyleCandlesticks,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              '/',
              style: textStyleCandlesticks,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              kProjectXLogoTransparentIcon,
              height: 30,
            ),
            const SizedBox(
              width: 7,
            ),
            const Text(
              PxStrings.countTitleUsdt,
              style: textStyleCandlesticks,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: textStyleCandlesticksNumber,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
