import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/ui/widgets/loading_window.dart';
import 'package:projectx/ui/widgets/login/form_wallet_import.dart';
import 'package:projectx/utils/toast_util.dart';

class WalletImportScreen extends StatefulWidget {
  const WalletImportScreen({Key? key}) : super(key: key);

  @override
  State<WalletImportScreen> createState() => _WalletImportScreenState();
}

class _WalletImportScreenState extends State<WalletImportScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoadedState) {
            Navigator.of(context).pop();
          } else if (state is AccountImportFailedState) {
            ToastUtil.makeToast(state.error);
          }
        },
      child: Stack(
        children: [
          DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: kBlueDark,
                  title: const Text(PxStrings.appBarTitle),
                  actions: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.wallet_travel_rounded,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                  bottom: const TabBar(
                    tabs: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          PxStrings.tapBarTitleOne,
                          style: textStyleButtonsHome,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          PxStrings.tapBarTitleTwo,
                          style: textStyleButtonsHome,
                        ),
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    FormWalletImport(isPhrase: true),
                    FormWalletImport(isPhrase: false)
                  ],
                ),
              )
          ),
          BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountImportingState) {
                  return const LoadingWidget();
                } else {
                  return Container();
                }
              },
          )
        ],
      ),
    );
  }
}
