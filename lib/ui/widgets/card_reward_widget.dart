import 'package:flutter/material.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/ui/screens/home/cubit/home_cubit.dart';
import 'package:projectx/utils/dialogs_util.dart';
import 'package:web3dart/web3dart.dart';

class CardReward extends StatelessWidget {
  final BigInt valueClaim;
  final String initials;
<<<<<<< HEAD
=======
  final HomeCubit cubit;
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
  final VoidCallback onClaimPressed;
  final bool disableButtonClaim;

  const CardReward({
    Key? key,
    required this.valueClaim,
    required this.initials,
<<<<<<< HEAD
=======
    required this.cubit,
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
    required this.onClaimPressed,
    required this.disableButtonClaim,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      height: 100,
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            kBackgroundCardRewardImage,
          ),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text.rich(
              TextSpan(
                style: textStyleRichText,
                children: [
                  TextSpan(
                    text: '${PxStrings.claimableReward}\n',
                    style: textStyleRichText.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '$valueClaim',
                    style: textStyleRichText.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: ' $initials',
                    style: textStyleRichText.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextButton(
              style: buttonStyleRounded,
              onPressed: valueClaim == BigInt.zero
                  ? null
                  : disableButtonClaim
                      ? null
                      : () {
                          onClaimPressed();
                        },
              child: const Text(
                PxStrings.claim,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
