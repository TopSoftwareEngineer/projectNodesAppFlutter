import 'package:flutter/material.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class InputAmountSwap extends StatelessWidget {

  final String token;
  final double balance;
  final bool isFrom, isEstimated;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onMaxClicked;

  const InputAmountSwap({Key? key,
    required this.token,
    required this.balance,
    required this.isFrom,
    required this.isEstimated,
    required this.controller,
    required this.focusNode,
    this.onMaxClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: kGray, width: 0.5),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (isFrom ? "From" : "To") + " " + (isEstimated ? "(estimated)" : ""),
                style: textStyleColor.copyWith(color: kGray),
              ),
              Text(
                balance < 0 ? "-" : balance.toStringAsFixed(token == PxStrings.avax ? 5 : 2),
                style: textStyleColor.copyWith(color: kGray),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    style: textStyleColor.copyWith(color: kWhite),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0.0',
                      hintStyle: textStyleColor.copyWith(color: kGrayLessDark),
                    ),
                  )
              ),
              if (isFrom && balance > 0) TextButton(
                  style: buttonStylebottomMax,
                  onPressed: onMaxClicked,
                  child: Text(
                    "MAX",
                    style: textStyleColor.copyWith(color: kBluePurple),
                  )
              ),
              if (isFrom) const SizedBox(width: 10),
              Image.asset(
                token == PxStrings.avax ? kAvalancheTokenIcon : kProjectXLogoTransparentIcon,
                height: 25,
              ),
              const SizedBox(width: 10,),
              Text(
                token,
                style: textStyleColor.copyWith(
                  color: kWhite,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}