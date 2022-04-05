import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/data/models/response.dart';
import 'package:projectx/ui/screens/home/cubit/home_cubit.dart';
import 'package:projectx/utils/toast_util.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogsUtil {
  confirmSwap({
    context,
    required String coinFrom,
    required String coinTo,
    required String valueCoinFrom,
    required String valueCoinTo,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
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
                confirmSwapInformation(
                  context: context,
                  coinFrom: coinFrom,
                  coinTo: coinTo,
                  valueCoinFrom: valueCoinFrom,
                  valueCoinTo: valueCoinTo,
                );
              },
              child: const Text(
                PxStrings.confirmYes,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                PxStrings.confirmNo,
              ),
            ),
          ],
        );
      },
    );
  }

  confirmSwapInformation({
    context,
    required String coinFrom,
    required String coinTo,
    required String valueCoinFrom,
    required String valueCoinTo,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        bool waitResponse = true;
        return StatefulBuilder(
          builder: (context, setState) {
            Future.delayed(const Duration(seconds: 5), () {
              waitResponse = true;
            }).whenComplete(() {
              waitResponse = false;
              setState(() {});
            });
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
              content: waitResponse
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
                                '${PxStrings.swapping} $valueCoinFrom $coinFrom ${PxStrings.forText} $valueCoinTo $coinTo',
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
                            onPressed: () => Navigator.of(context).pop(),
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
          },
        );
      },
    );
  }

  confirmButtonSwap({
    context,
    required String coinFrom,
    required String coinTo,
    required String valueCoinFrom,
    required String valueCoinTo,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: kBluedark2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              titlePadding: const EdgeInsets.only(
                left: 15,
                right: 0,
              ),
              contentPadding: const EdgeInsets.all(0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    PxStrings.confirmarSwap,
                    style: textStyleButtonsHome.copyWith(
                      color: kWhite,
                      fontSize: 18,
                    ),
                  ),
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
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    coinFrom == PxStrings.avax
                                        ? kAvalancheTokenIcon
                                        : kProjectXLogoTransparentIcon,
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    valueCoinFrom,
                                    style: textStyleColor.copyWith(
                                      color: kWhite,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                coinFrom,
                                style: textStyleColor.copyWith(
                                  color: kWhite,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              constraints: const BoxConstraints(
                                minWidth: 15,
                                minHeight: 15,
                              ),
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: kGrayLight,
                                size: 15,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    coinTo == PxStrings.avax
                                        ? kAvalancheTokenIcon
                                        : kProjectXLogoTransparentIcon,
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    valueCoinTo,
                                    style: textStyleColor.copyWith(
                                      color: kWhite,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                coinTo,
                                style: textStyleColor.copyWith(
                                  color: kWhite,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              style: textStyleColor.copyWith(
                                color: kGrayLight,
                                fontSize: 12,
                              ),
                              children: [
                                const TextSpan(text: PxStrings.outputEstimated),
                                TextSpan(
                                  text: '$valueCoinTo $coinTo ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const TextSpan(
                                    text: PxStrings.transactionRevert),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: kGrayLessDark,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    PxStrings.precio,
                                    style: textStyleColor.copyWith(
                                      color: kGray,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          style: textStyleColor.copyWith(
                                            color: kGray,
                                            fontSize: 12,
                                          ),
                                          children: const [
                                            TextSpan(text: '0.0112289'),
                                            TextSpan(text: PxStrings.avax),
                                            TextSpan(text: PxStrings.per),
                                            TextSpan(text: PxStrings.pxt2),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        padding: const EdgeInsets.all(5),
                                        constraints: const BoxConstraints(
                                          minWidth: 10,
                                          minHeight: 10,
                                        ),
                                        iconSize: 15,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.sync,
                                          color: kGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      PxStrings.minimoRecibido,
                                      style: textStyleColor.copyWith(
                                        color: kGray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '1063 PXT2',
                                      style: textStyleColor.copyWith(
                                        color: kWhite,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                    PxStrings.impactoPrecio,
                                    style: textStyleColor.copyWith(
                                      color: kGray,
                                      fontSize: 12,
                                    ),
                                  )),
                                  Expanded(
                                    child: Text(
                                      '0.01%',
                                      style: textStyleColor.copyWith(
                                        color: kGreen,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      PxStrings.tasaProveedor,
                                      style: textStyleColor.copyWith(
                                        color: kGray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '0.036 AVAX',
                                      style: textStyleColor.copyWith(
                                        color: kWhite,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                            style: buttonStyleTokenActivate,
                            onPressed: () {
                              Navigator.of(context).pop();
                              confirmSwapInformation(
                                context: context,
                                coinFrom: coinFrom,
                                coinTo: coinTo,
                                valueCoinFrom: valueCoinFrom,
                                valueCoinTo: valueCoinTo,
                              );
                            },
                            child: Text(
                              PxStrings.confirmarSwap,
                              style: textStyleButtonsHome.copyWith(
                                color: kWhite,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  waitingStatus({
    context,
    required HomeCubit cubit,
    required int action,
    required BigInt amount,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => HomeCubit(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                if (action == 2) {
                  cubit.cashoutAll();
                } else {
                  cubit.createNodeWithTokens(
                    numberOfNodes: amount,
                  );
                }
              }
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
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
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  confirmHomeAction({
    context,
    required int action,
    required String amount,
    required HomeCubit cubit,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kBluedark2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          title: Text(
            '${action == 1 ? PxStrings.confirmCreateNodesPart1 : PxStrings.confirmClaimNodesPart1} $amount ${action == 2 ? PxStrings.confirmClaimNodesPart2 : int.parse(amount) >= 2 ? PxStrings.confirmCreateNodesPart2 : PxStrings.confirmCreateNodesPart2Uni}',
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
                waitingStatus(
                  context: context,
                  action: action,
                  cubit: cubit,
                  amount: BigInt.from(double.parse(amount)),
                );
              },
              child: const Text(
                PxStrings.confirmYes,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                PxStrings.confirmNo,
              ),
            ),
          ],
        );
      },
    );
  }

  rpcDialog({
    context,
    required String rpc,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kBlueLight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          title: SelectableText(
            rpc == PxStrings.rpcIsEmpty
                ? PxStrings.rpcIsEmpty
                : PxStrings.rpcUrl + rpc,
            textAlign: TextAlign.center,
            style: textStyleRichText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  dialogInformationFuntionHome({
    context,
    required Response response,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.check,
                      color: kGreen,
                      size: 80,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          response.message,
                          textAlign: TextAlign.center,
                          style: textStyleRichText.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          style: buttonStylebottomless,
                          onPressed: () => launch(response.tx),
                          child: Text(
                            response.tx,
                            textAlign: TextAlign.center,
                            style: textStyleColor.copyWith(
                              color: kBlueLight,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
