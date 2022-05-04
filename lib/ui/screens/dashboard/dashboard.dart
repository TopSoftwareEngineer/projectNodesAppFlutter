import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/router/router_path.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/ui/widgets/card_information_widget.dart';
import 'package:projectx/ui/widgets/card_reward_widget.dart';
import 'package:projectx/ui/widgets/dialog/claim_dialog.dart';
import 'package:projectx/ui/widgets/dialog/node_create_amount_dialog.dart';
import 'package:projectx/ui/widgets/dialog/node_creation_progress_dialog.dart';
import 'package:projectx/ui/widgets/list_tile_items_widget.dart';
import 'package:projectx/ui/widgets/list_tile_node_widget.dart';
import 'package:projectx/utils/web3/wallet_account.dart';
import 'package:web3dart/web3dart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late WalletAccount _walletAccount;
  late String _latestAVAXPriceUSDT;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    AccountLoadedState state = AppBloc.accountBloc.state as AccountLoadedState;
    _walletAccount = state.account;
    _latestAVAXPriceUSDT = "0.00";
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _walletAccount.getLatestAVAXPriceUSDT().then((value) {
        setState(() {
          _latestAVAXPriceUSDT = value.toRadixString(2);
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String address = _walletAccount.address.hex;
    double balanceAVAX = _walletAccount.balanceAVAX;
    double balancePXT2 = _walletAccount.balancePXT2;
    int numberOfNodes = _walletAccount.rewardAvailableNodeList.length;
    return Stack(
      children: [
        Image.asset(
          kBackgroundHomeImage,
          height: 250,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Scaffold(
          backgroundColor: kTransparent,
          appBar: AppBar(
            backgroundColor: kTransparent,
            centerTitle: true,
            leading: IconButton(
              onPressed: () async {
                AppBloc.accountBloc.add(AccountLogoutEvent());
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${address.substring(0, 5)}...${address.substring(address.length - 4, address.length)}'),
                Text('Balance: ${balancePXT2.toStringAsFixed(2)} PXT', style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 30),
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: kWhite,
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    '2',
                    style: textStyleColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 45),
                    child: Text.rich(
                      TextSpan(
                        style: textStyleRichText,
                        children: [
                          TextSpan(
                            text: '${PxStrings.myNodes}\n',
                            style: textStyleRichText.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$numberOfNodes/100\n',
                          ),
                          TextSpan(
                            text: PxStrings.universalNodes,
                            style: textStyleRichText.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 25),
                    child: TextButton(
                      style: buttonStyleRounded,
                      onPressed: () => showNodeCreateAmountDialog(context),
                      child: const Text(
                        '${PxStrings.create} ${PxStrings.nodes}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardInformation(
                      icon: kAvalancheTokenIcon,
                      nameProject: 'Avalanche',
                      initialsProject: 'AVAX',
                      valueUsdt: _latestAVAXPriceUSDT,
                      value: -0.45,
                    ),
                    const CardInformation(
                      icon: kProjectXLogoTransparentIcon,
                      nameProject: 'ProjectX',
                      initialsProject: 'PXT2',
                      valueUsdt: '21.50',
                      value: 0.56,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$numberOfNodes ${PxStrings.nodesActivated}',
                      style: textStyleFontSize,
                    ),
                    if (numberOfNodes > 0)
                      TextButton(
                        style: buttonStylebottomless,
                        onPressed: () =>
                            Navigator.of(context).pushNamed(
                              PxPathCfg.nodeListScreenPageRoute,
                              arguments: {
                                'listNode': _walletAccount.rewardAvailableNodeList,
                                'cantNodes': numberOfNodes.toString(),
                              },
                            ),
                        child: const Text(
                          PxStrings.seeAll,
                          style: textStyleColor,
                        ),
                      )
                  ],
                ),
              ),
              Expanded(
                  child: SafeArea(
                    minimum: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: ListView(
                      children: [
                        ..._walletAccount
                            .rewardAvailableNodeList
                            .map<ListTileNode>((e) => ListTileNode(node: e)).toList(),
                        CardReward(
                          initials: 'PXT2',
                          valueClaim: _walletAccount.rewardAmount,
                          disableButtonClaim: false,
                          onClaimPressed: () => showClaimDialog(context, _walletAccount.rewardAmount),
                        ),
                        const ListTileItems(
                          title: PxStrings.dailyItem,
                          value: '0.17 PXT2',
                        ),
                        const ListTileItems(
                          title: PxStrings.rewardItem,
                          value: '1 hr',
                        ),
                        const ListTileItems(
                          title: PxStrings.nodeItem,
                          value: '10 PXT2',
                        ),
                        const ListTileItems(
                          title: PxStrings.claimItem,
                          value: '0%',
                        ),
                        const ListTileItems(
                          title: PxStrings.sellItem,
                          value: '18%',
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
      ],
    );
  }

  void showNodeCreateAmountDialog(BuildContext context) async {
    final amount = await showDialog(
        context: context,
        builder: (context) => const NodeCreateAmountDialog()
    );
    if (amount != null) {
      AppBloc.accountBloc.add(AccountCreateNodesEvent(amount: amount));
      showNodeCreationProgressDialog(context);
    }
  }

  void showNodeCreationProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const NodeCreationProgressDialog()
    );
  }

  void showClaimDialog(BuildContext context, BigInt amount) {
    showDialog(
        context: context,
        builder: (context) => ClaimingDialog(amount: amount));
  }
}
