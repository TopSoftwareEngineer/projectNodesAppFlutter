import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class NodeCreationProgressDialog extends StatelessWidget {
  const NodeCreationProgressDialog({Key? key}) : super(key: key);

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
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(),
              ),
              Text(
                PxStrings.waitingResponse,
                textAlign: TextAlign.center,
                style: textStyleRichText.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
