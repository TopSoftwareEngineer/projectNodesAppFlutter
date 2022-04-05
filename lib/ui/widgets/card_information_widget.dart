import 'package:flutter/material.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class CardInformation extends StatelessWidget {
  final String icon;
  final String nameProject;
  final String initialsProject;
  final String valueUsdt;
  final double value;
   const CardInformation({
    Key? key,
    required this.icon,
    required this.nameProject,
    required this.initialsProject,
    required this.valueUsdt,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: kGray,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameProject,
                      style: textStyleFontWeight,
                    ),
                    Text(
                      initialsProject,
                      style: textStyleColor.copyWith(
                        color: kGray,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: '$valueUsdt ${PxStrings.usdt}\n',
                  style: textStyleFontWeight.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: value.isNegative
                      ? value.toStringAsFixed(2)
                      : '+' + value.toStringAsFixed(2),
                  style: value.isNegative
                      ? textStyleColor.copyWith(color: kRed)
                      : textStyleColor.copyWith(color: kGreen),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
