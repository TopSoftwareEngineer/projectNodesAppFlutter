import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class ClaimingDialog extends StatelessWidget {

  final BigInt amount;

  const ClaimingDialog({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoadedState) {
            Navigator.of(context).pop();
          }
        },
      child: AlertDialog(
        backgroundColor: kBluedark2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Text(
          '${PxStrings.confirmClaimNodesPart1} $amount ${PxStrings.confirmClaimNodesPart2}',
          textAlign: TextAlign.center,
          style: textStyleRichText.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountRefreshingState) {
                  return const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TextButton(
                    style: buttonStyleActivate,
                    onPressed: () {
                      AppBloc.accountBloc.add(AccountClaimRewardEvent(amount: amount));
                    },
                    child: const Text(
                      PxStrings.claim,
                    ),
                  );
                }
              },
          )
        ],
      ),
    );
  }
}
