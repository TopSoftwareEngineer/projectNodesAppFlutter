import 'package:flutter/material.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class NodeCreateAmountDialog extends StatelessWidget {
  const NodeCreateAmountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = 1;
    return StatefulBuilder(
      builder: (ctx, setDialogState) {
        return AlertDialog(
          backgroundColor: kBluedark2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          title: Text(
            '${PxStrings.confirmCreateNodesPart1} $amount ${amount >= 2 ? PxStrings.confirmCreateNodesPart2 : PxStrings.confirmCreateNodesPart2Uni}',
            textAlign: TextAlign.center,
            style: textStyleRichText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  constraints: const BoxConstraints(
                    minHeight: 5,
                    minWidth: 5,
                  ),
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    if (amount - 1 >= 1) {
                      amount--;
                    }
                    setDialogState(() {});
                  },
                  icon: const Icon(
                    Icons.remove,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 10,
                ),
                child: IconButton(
                  constraints: const BoxConstraints(
                    minHeight: 5,
                    minWidth: 5,
                  ),
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    if (amount + 1 <= 10) {
                      amount++;
                    }
                    setDialogState(() {});
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              style: buttonStyleActivate,
              onPressed: () {
                Navigator.of(context).pop(amount);
              },
              child: const Text(
                PxStrings.createNode,
              ),
            ),
          ],
        );
      },
    );
  }
}
