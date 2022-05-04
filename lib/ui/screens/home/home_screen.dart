import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
=======
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/router/router_path.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/ui/widgets/card_information_widget.dart';
import 'package:projectx/ui/widgets/card_reward_widget.dart';
import 'package:projectx/ui/widgets/list_tile_items_widget.dart';
import 'package:projectx/ui/widgets/list_tile_node_widget.dart';
import 'package:projectx/utils/dialogs_util.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';
import 'package:projectx/utils/toast_util.dart';
import 'package:web3dart/web3dart.dart';

import 'cubit/home_cubit.dart';

const Widget spaceBetween = SizedBox(
  height: 15,
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool disableButtonClaim = false;
    List<Node> listNode3 = [];
    String titleAppbar = '';
<<<<<<< HEAD
    //String balance = '';
    BigInt balance = BigInt.zero;
=======
    String balance = '';
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
    BigInt claimValue = BigInt.zero;
    String cantNodes = '';
    List<Node> listNode = [];
    String latestRoundData = '';
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit _cubit = BlocProvider.of<HomeCubit>(context);
        if (state is LoadedInitialData) {
          cantNodes = state.nodeNumberOf.toString();
          listNode = state.listNodes;
          listNode3 = [];
          int cont = 0;
          for (var element in listNode) {
            cont++;
            if (cont <= 3) {
              listNode3.add(element);
            }
          }
<<<<<<< HEAD
          balance = (EtherAmount.inWei(state.balanceOf.getInEther).getInEther);
=======
          balance = (EtherAmount.inWei(state.balanceOf.getInEther).getInEther)
              .toString();
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
          //balance = state.balanceOf.getInEther.toString();
          claimValue = EtherAmount.inWei(state.rewardAmountOf).getInEther;
          titleAppbar = state.publicKey;
          _cubit.getLatestRoundData();
        }
        if (state is LoadedlatestRoundData) {
          latestRoundData = state.latestRoundData.toString();
          Future.delayed(const Duration(seconds: 1), () {
            _cubit.getLatestRoundData();
          });
        }
        if (state is LoadedCashoutAll) {
          Future.delayed(const Duration(seconds: 10)).whenComplete(() {
            ToastUtil.makeToast(state.response.message);
            Navigator.of(context).pop();
            _cubit.getInitialData();
            if (state.response.status) {
              DialogsUtil().dialogInformationFuntionHome(
                context: context,
                response: state.response,
              );
            }
          });
          if (state.response.status) {
            disableButtonClaim = true;
            Future.delayed(Duration(seconds: state.seconds)).whenComplete(() {
              disableButtonClaim = false;
            });
          }
        }
        if (state is LoadedCreateNodeWithTokens) {
          Future.delayed(const Duration(seconds: 10)).whenComplete(() {
            ToastUtil.makeToast(state.response.message);
            Navigator.of(context).pop();
            _cubit.getInitialData();
            if (state.response.status) {
              DialogsUtil().dialogInformationFuntionHome(
                context: context,
                response: state.response,
              );
            }
          });
        }
        return Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  kBackgroundHomeImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                )
              ],
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: kTransparent,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () async {
<<<<<<< HEAD
                      AppBloc.accountBloc.add(AccountLogoutEvent());
=======
                      await SharedPreferencesUtil.removeAllItem();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          PxPathCfg.initialScreenPageRoute, (route) => false);
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        titleAppbar.isEmpty
                            ? ''
                            : '${titleAppbar.substring(0, 5)}...${titleAppbar.substring(titleAppbar.length - 4, titleAppbar.length)}',
                      ),
                      Text(
<<<<<<< HEAD
                        balance.toString().isEmpty ? '' : 'Balance: $balance PXT',
=======
                        balance.isEmpty ? '' : 'Balance: $balance PXT',
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
                        style: const TextStyle(fontSize: 13),
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
                spaceBetween,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text.rich(
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
                            text: '$cantNodes/100\n',
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
                    ButtonCreateNodes(
                      context: context,
                      cubit: _cubit,
                      onButtonPressed: () =>
<<<<<<< HEAD
                          showCreatesNodesAmountDialog(context, _cubit, balance)),
=======
                          showCreatesNodesAmountDialog(context, _cubit),
                    ),
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
                  ],
                ),
                spaceBetween,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardInformation(
                      icon: kAvalancheTokenIcon,
                      nameProject: 'Avalanche',
                      initialsProject: 'AVAX',
                      valueUsdt: latestRoundData,
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
                spaceBetween,
                Expanded(
                  child: SafeArea(
                    minimum: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$cantNodes ${PxStrings.nodesActivated}',
                              style: textStyleFontSize,
                            ),
                            if (cantNodes != '0' && cantNodes != '')
                              TextButton(
                                style: buttonStylebottomless,
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                  PxPathCfg.nodeListScreenPageRoute,
                                  arguments: {
                                    'listNode': listNode,
                                    'cantNodes': cantNodes,
                                  },
                                ),
                                child: const Text(
                                  PxStrings.seeAll,
                                  style: textStyleColor,
                                ),
                              )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: listNode3
                              .map(
                                (e) => ListTileNode(
                                  node: e,
                                ),
                              )
                              .toList(),
                        ),
                        CardReward(
                          initials: 'PXT2',
                          valueClaim: claimValue,
<<<<<<< HEAD
=======
                          cubit: _cubit,
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
                          disableButtonClaim: disableButtonClaim,
                          onClaimPressed: () =>
                              showClaimDialog(context, claimValue, _cubit),
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
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

<<<<<<< HEAD
  void showCreatesNodesAmountDialog(BuildContext context, HomeCubit cubit, BigInt balanceOf) {
=======
  void showCreatesNodesAmountDialog(BuildContext context, HomeCubit cubit) {
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
    showDialog(
      context: context,
      builder: (context) {
        var amount = 1;
        return StatefulBuilder(builder: (ctx, setDialogState) {
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
<<<<<<< HEAD
                onPressed: balanceOf < BigInt.from(1) ? null : () => _showCreateNodeDialog(context, cubit, amount),
=======
                onPressed: () {
                  Navigator.of(context).pop();
                  DialogsUtil().waitingStatus(
                      cubit: cubit,
                      action: 1,
                      amount: BigInt.from(amount),
                      context: context);
                  /*waitingStatus(
                context: context,
                action: action,
                cubit: cubit,
                amount: BigInt.from(amount),
              );*/
                },
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
                child: const Text(
                  PxStrings.createNode,
                ),
              ),
              /*TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  PxStrings.confirmNo,
                ),
              ),*/
            ],
          );
        });
      },
    );
  }

<<<<<<< HEAD
  void _showCreateNodeDialog(BuildContext context, HomeCubit cubit, int amount) {
{
                  Navigator.of(context).pop();
                  DialogsUtil().waitingStatus(
                      cubit: cubit,
                      action: 1,
                      amount: BigInt.from(amount),
                      context: context);
                  /*waitingStatus(
                context: context,
                action: action,
                cubit: cubit,
                amount: BigInt.from(amount),
              );*/
                }
  }

=======
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
  void showClaimDialog(BuildContext context, BigInt amount, HomeCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        var claiming = false;
        return StatefulBuilder(builder: (ctx, setDialogState) {
          return AlertDialog(
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
            actions: <Widget>[
              if (claiming)
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                )
              else
                TextButton(
                  style: buttonStyleActivate,
                  onPressed: () {
                    claiming = true;
                    setDialogState(() {});
                    cubit.cashoutAll();
                    //Navigator.of(context).pop();

                    /*DialogsUtil().waitingStatus(
                      cubit: cubit,
                      action: 1,
                      amount: BigInt.from(amount),
                      context: context);*/
                    /*waitingStatus(
                context: context,
                action: action,
                cubit: cubit,
                amount: BigInt.from(amount),
              );*/
                  },
                  child: const Text(
                    PxStrings.claim,
                  ),
                ),
              /*TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  PxStrings.confirmNo,
                ),
              ),*/
            ],
          );
        });
      },
    );
  }
}

class ButtonCreateNodes extends StatefulWidget {
  final BuildContext context;
  final HomeCubit cubit;
  final VoidCallback onButtonPressed;
  const ButtonCreateNodes({
    Key? key,
    required this.context,
    required this.cubit,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  _ButtonCreateNodesState createState() => _ButtonCreateNodesState();
}

class _ButtonCreateNodesState extends State<ButtonCreateNodes> {
  int contNodes = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
            style: buttonStyleRounded,
            onPressed: widget.onButtonPressed,

            /* () => DialogsUtil().confirmHomeAction(
              context: widget.context,
              action: 1,
              amount: contNodes.toString(),
              cubit: widget.cubit,
            ),*/
            child: const Text(
              // '${PxStrings.create} $contNodes \n ${contNodes >= 2 ? PxStrings.nodes : PxStrings.node}',
              '${PxStrings.create} ${PxStrings.nodes}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
