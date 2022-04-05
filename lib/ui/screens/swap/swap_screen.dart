import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/utils/dialogs_util.dart';

const Widget spaceBetween = SizedBox(
  width: 10,
);

const Widget spaceHeight = SizedBox(
  height: 10,
);

class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final TextEditingController textEditingFromController =
      TextEditingController();
  final TextEditingController textEditingToController = TextEditingController();
  bool noEmpty = false;
  bool mayorFrom = false;
  String coinFrom = PxStrings.avax;
  String coinTo = PxStrings.pxt2;
  bool changed = false;
  void onChange() {
    if (textEditingFromController.text.isNotEmpty ||
        textEditingToController.text.isNotEmpty) {
      if (double.parse(textEditingFromController.text) >
          double.parse(textEditingToController.text)) {
        mayorFrom = true;
      } else {
        mayorFrom = false;
      }
      noEmpty = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    noEmpty = false;
    textEditingFromController.addListener(onChange);
    textEditingToController.addListener(onChange);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text.rich(
                TextSpan(
                  style: textStyleFont.copyWith(
                    fontSize: 18,
                  ),
                  children: [
                    const TextSpan(text: PxStrings.ordenlimite),
                    TextSpan(
                      text: 'Velox',
                      style: textStyleColor.copyWith(
                        color: kOrangedark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: kBluedark2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputTokenAmount(
                    coin: coinFrom,
                    valueBalance: '0.121417',
                    controller: changed
                        ? textEditingToController
                        : textEditingFromController,
                    noEmpty: noEmpty,
                  ),
                  IconButton(
                    onPressed: () {
                      changed = !changed;
                      String boxText = coinFrom;
                      coinFrom = coinTo;
                      coinTo = boxText;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: kBlueLight,
                    ),
                  ),
                  InputTokenAmount(
                    coin: coinTo,
                    valueBalance: '0',
                    showFrom: false,
                    controller: changed
                        ? textEditingFromController
                        : textEditingToController,
                    noEmpty: noEmpty,
                  ),
                  if (noEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          PxStrings.precio,
                          style: textStyleColor.copyWith(
                            color: kGray,
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
                  spaceHeight,
                  if (!changed)
                    TextButton(
                      style: mayorFrom
                          ? buttonStyleTokenActivate
                          : buttonStyleToken,
                      onPressed: () async {
                        if (mayorFrom) {
                          DialogsUtil().confirmSwap(
                            context: context,
                            coinFrom: coinFrom,
                            coinTo: coinTo,
                            valueCoinFrom: changed
                                ? textEditingToController.text
                                : textEditingFromController.text,
                            valueCoinTo: changed
                                ? textEditingFromController.text
                                : textEditingToController.text,
                          );
                        }
                      },
                      child: Text(
                        noEmpty
                            ? mayorFrom
                                ? PxStrings.confirmarSwap
                                : PxStrings.insuficienteBalance
                            : PxStrings.introduzcaCantidad,
                        style: mayorFrom
                            ? textStyleButtonsHome.copyWith(
                                color: kWhite,
                                fontSize: 18,
                              )
                            : textStyleButtonsHome.copyWith(
                                color: kGrayLight,
                                fontSize: 18,
                              ),
                      ),
                    ),
                  if (changed)
                    ButtonsAprove(
                      coinFrom: coinFrom,
                      coinTo: coinTo,
                      textEditingFromController: changed
                          ? textEditingToController
                          : textEditingFromController,
                      textEditingToController: changed
                          ? textEditingFromController
                          : textEditingToController,
                    ),
                ],
              ),
            ),
            if (noEmpty)
              Container(
                padding: const EdgeInsets.all(15),
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  color: kBlueLessDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            PxStrings.minimoRecibido,
                            style: textStyleColor.copyWith(
                              color: kGray,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '1063 PXT2',
                            style: textStyleColor.copyWith(
                              color: kWhite,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          PxStrings.impactoPrecio,
                          style: textStyleColor.copyWith(
                            color: kGray,
                          ),
                        )),
                        Expanded(
                          child: Text(
                            '0.01%',
                            style: textStyleColor.copyWith(
                              color: kGreen,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            PxStrings.tasaProveedor,
                            style: textStyleColor.copyWith(
                              color: kGray,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '0.036 AVAX',
                            style: textStyleColor.copyWith(
                              color: kWhite,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (noEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text.rich(
                  TextSpan(
                    style: textStyleFont.copyWith(
                      fontSize: 18,
                    ),
                    children: [
                      const TextSpan(text: PxStrings.opereApalancamiento),
                      TextSpan(
                        text: 'MarginSwap',
                        style: textStyleColor.copyWith(
                          color: kOrangedark,
                        ),
                      ),
                      const TextSpan(
                        text: ' o ',
                      ),
                      TextSpan(
                        text: 'WowSwap',
                        style: textStyleColor.copyWith(
                          color: kOrangedark,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class InputTokenAmount extends StatefulWidget {
  final String coin;
  final String valueBalance;
  final bool showFrom;
  final TextEditingController controller;
  final bool noEmpty;

  const InputTokenAmount({
    Key? key,
    required this.coin,
    required this.valueBalance,
    this.showFrom = true,
    required this.controller,
    required this.noEmpty,
  }) : super(key: key);

  @override
  State<InputTokenAmount> createState() => _InputTokenAmountState();
}

class _InputTokenAmountState extends State<InputTokenAmount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: kGray,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.showFrom
                    ? PxStrings.desde
                    : widget.noEmpty
                        ? PxStrings.aEstimado
                        : PxStrings.a,
                style: textStyleColor.copyWith(
                  color: kGray,
                ),
              ),
              Text(
                widget.noEmpty
                    ? '${PxStrings.balance} ${widget.valueBalance}'
                    : PxStrings.noBalance,
                style: textStyleColor.copyWith(
                  color: kGray,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: widget.controller,
                  style: textStyleColor.copyWith(
                    color: kWhite,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: PxStrings.hintInput,
                    hintStyle: textStyleColor.copyWith(
                      color: kGrayLessDark,
                    ),
                  ),
                ),
              ),
              if (widget.showFrom)
                TextButton(
                  style: buttonStylebottomMax,
                  onPressed: () {},
                  child: Text(
                    PxStrings.max,
                    style: textStyleColor.copyWith(
                      color: kBluePurple,
                    ),
                  ),
                ),
              if (widget.showFrom) spaceBetween,
              Row(
                children: [
                  Image.asset(
                    widget.coin == PxStrings.avax
                        ? kAvalancheTokenIcon
                        : kProjectXLogoTransparentIcon,
                    height: 25,
                  ),
                  spaceBetween,
                  Text(
                    widget.coin,
                    style: textStyleColor.copyWith(
                      color: kWhite,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonsAprove extends StatefulWidget {
  final String coinFrom;
  final String coinTo;
  final TextEditingController textEditingFromController;
  final TextEditingController textEditingToController;

  const ButtonsAprove({
    Key? key,
    required this.coinFrom,
    required this.textEditingFromController,
    required this.textEditingToController,
    required this.coinTo,
  }) : super(key: key);

  @override
  _ButtonsAproveState createState() => _ButtonsAproveState();
}

class _ButtonsAproveState extends State<ButtonsAprove> {
  bool enableButton1 = true;
  bool enableButton2 = false;
  bool approved = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: approved
                      ? kGrayLight
                      : enableButton1
                          ? kBlueLight
                          : kGrayLessDark,
                ),
                onPressed: () {
                  if (!approved) {
                    loading = true;
                    setState(() {});
                    Future.delayed(const Duration(seconds: 5), () {})
                        .whenComplete(() {
                      loading = false;
                      approved = true;
                      enableButton2 = true;
                      setState(() {});
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      approved
                          ? PxStrings.approvedSwap
                          : loading
                              ? PxStrings.approvingSwap
                              : '${PxStrings.approveSwap} ${widget.coinFrom}',
                      style: textStyleColor.copyWith(
                        color: approved
                            ? kGreenDark
                            : enableButton1
                                ? kWhite
                                : kGrayLight,
                      ),
                    ),
                    if (loading)
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: 15,
                        width: 15,
                        child: const CircularProgressIndicator(
                          color: kWhite,
                          strokeWidth: 2,
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: enableButton2 ? kBlueLight : kGrayLessDark,
                ),
                onPressed: () {
                  DialogsUtil().confirmButtonSwap(
                    context: context,
                    coinFrom: widget.coinFrom,
                    coinTo: widget.coinTo,
                    valueCoinFrom: widget.textEditingFromController.text,
                    valueCoinTo: widget.textEditingToController.text,
                  );
                },
                child: Text(
                  PxStrings.swap,
                  style: textStyleColor.copyWith(
                    color: enableButton2 ? kWhite : kGrayLight,
                  ),
                ),
              ),
            ),
          ],
        ),
        NumberStepper(
          stepColor: approved ? kGreen : kGrayLessDark,
          activeStepColor: kBlueLight,
          stepRadius: 10,
          lineLength: size.width * 0.35,
          enableNextPreviousButtons: false,
          enableStepTapping: false,
          activeStep: approved ? 1 : 0,
          numbers: const [
            1,
            2,
          ],
        ),
      ],
    );
  }
}
