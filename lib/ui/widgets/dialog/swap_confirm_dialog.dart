import 'package:flutter/material.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class SwapConfirmDialog extends StatelessWidget {

  final VoidCallback onYes, onNo;

  const SwapConfirmDialog({Key? key, required this.onYes, required this.onNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBluedark2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      title: Text(
        PxStrings.confirmMessage,
        textAlign: TextAlign.center,
        style: textStyleRichText.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          style: buttonStyleActivate,
          onPressed: () {
            Navigator.of(context).pop();
            onYes();
          },
          child: const Text(
            PxStrings.confirmYes,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onNo();
          },
          child: const Text(
            PxStrings.confirmNo,
          ),
        ),
      ],
    );
  }
}
