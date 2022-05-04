import 'package:flutter/material.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class SwapProgressDialog extends StatelessWidget {
  final String tokenFrom, tokenTo, amountFrom, amountTo;
  final bool waiting;
  final VoidCallback onClose;

  const SwapProgressDialog({Key? key, required this.tokenFrom, required this.tokenTo, required this.amountFrom, required this.amountTo, required this.waiting, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBluedark2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      titlePadding: const EdgeInsets.all(0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: kWhite,
            ),
          ),
        ],
      ),
      content: waiting
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        PxStrings.waitingMessage,
                        textAlign: TextAlign.center,
                        style: textStyleRichText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${PxStrings.swapping} $amountFrom $tokenFrom ${PxStrings.forText} $amountTo $tokenTo',
                        textAlign: TextAlign.center,
                        style: textStyleRichText.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        PxStrings.confirmTransaction,
                        textAlign: TextAlign.center,
                        style: textStyleColor.copyWith(
                          color: kGrayLight,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    kArrowUpIcon,
                    height: 80,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        PxStrings.transactionSubmitted,
                        textAlign: TextAlign.center,
                        style: textStyleRichText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        PxStrings.snowtraceExplorer,
                        textAlign: TextAlign.center,
                        style: textStyleColor.copyWith(
                          color: kBlueLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    style: buttonStyleTokenActivate,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onClose();
                    },
                    child: Text(
                      PxStrings.close,
                      style: textStyleButtonsHome.copyWith(
                        color: kWhite,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
