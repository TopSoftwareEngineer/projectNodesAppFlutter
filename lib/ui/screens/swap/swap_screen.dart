import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:im_stepper/stepper.dart';
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/ui/widgets/dialog/swap_confirm_dialog.dart';
import 'package:projectx/ui/widgets/swap/input_amount_swap.dart';
import 'package:projectx/utils/toast_util.dart';
import 'package:projectx/utils/web3/wallet_account.dart';
import 'package:projectx/utils/web3/web3_api.dart';
import 'package:web3dart/web3dart.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  late WalletAccount _walletAccount;

  final List<String> _tokens = [PxStrings.avax, PxStrings.pxt2];
  int _tokenFromIndex = 0;
  int _estimatedIndex = -1;
  final Map<String, double> _balances = {PxStrings.avax: -1, PxStrings.pxt2: -1};
  final Map<String, double> _swapAmounts = {PxStrings.avax: 0, PxStrings.pxt2: 0};
  double _tokenPriceInAVAX = 0;
  bool _showPricePxtPerAVAX = true;
  final TextEditingController _controllerFrom = TextEditingController(), _controllerTo = TextEditingController();
  final FocusNode _focusFrom = FocusNode(), _focusTo = FocusNode();
  bool _waitingSwapResponse = false;
  String? _swapResult;

  @override
  void initState() {
    super.initState();
    AccountLoadedState state = AppBloc.accountBloc.state as AccountLoadedState;
    _walletAccount = state.account;
    _balances[PxStrings.avax] = _walletAccount.balanceAVAX;
    _balances[PxStrings.pxt2] = _walletAccount.balancePXT2;
    Web3Api().getTokenPriceInAVAX().then((value) {
      setState(() {
        _tokenPriceInAVAX = value;
      });
    });
    _controllerFrom.text = "";
    _controllerTo.text = "";
    _controllerFrom.addListener(onFromAmountChanged);
    _controllerTo.addListener(onToAmountChanged);
  }

  @override
  void dispose() {
    _controllerFrom.dispose();
    _controllerTo.dispose();
    _focusFrom.dispose();
    _focusTo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountLoadedState) {
          setState(() {
            _walletAccount = state.account;
            _balances[PxStrings.avax] = _walletAccount.balanceAVAX;
            _balances[PxStrings.pxt2] = _walletAccount.balancePXT2;
          });
        }
      },
      child: Stack(
        children: [
          Center(
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
                        InputAmountSwap(
                          controller: _controllerFrom,
                          focusNode: _focusFrom,
                          token: _tokens[_tokenFromIndex],
                          balance: _balances[_tokens[_tokenFromIndex]]!,
                          isFrom: true,
                          isEstimated: _estimatedIndex == _tokenFromIndex,
                          onMaxClicked: () {
                            _focusFrom.requestFocus();
                            _swapAmounts[_tokens[_tokenFromIndex]] = _balances[_tokens[_tokenFromIndex]]!;
                            _controllerFrom.text = _swapAmounts[_tokens[_tokenFromIndex]].toString();
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            _tokenFromIndex = 1 - _tokenFromIndex;
                            _showPricePxtPerAVAX = _tokenFromIndex == 0;
                            _controllerFrom.text = _swapAmounts[_tokens[_tokenFromIndex]].toString();
                            _controllerTo.text = _swapAmounts[_tokens[1 - _tokenFromIndex]].toString();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: kBlueLight,
                          ),
                        ),
                        InputAmountSwap(controller: _controllerTo, focusNode: _focusTo, token: _tokens[1 - _tokenFromIndex], balance: _balances[_tokens[1 - _tokenFromIndex]]!, isFrom: false, isEstimated: _estimatedIndex == (1 - _tokenFromIndex)),
                        buildPriceLine(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (_tokenFromIndex == 0)
                          TextButton(
                            style: isSwappable() ? buttonStyleTokenActivate : buttonStyleToken,
                            onPressed: () async {
                              if (isSwappable()) {
                                confirmSwap();
                              }
                            },
                            child: Text(
                              isSwappable()
                                  ? PxStrings.confirmarSwap
                                  : _controllerFrom.text.isEmpty
                                      ? PxStrings.introduzcaCantidad
                                      : PxStrings.insuficienteBalance,
                              style: isSwappable()
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
                        if (_tokenFromIndex == 1)
                          ButtonsAprove(
                            walletAccount: _walletAccount,
                            onSwap: () => confirmSwap(),
                          ),
                      ],
                    ),
                  ),
                  if (_controllerFrom.text.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: size.width * 0.85,
                      margin: const EdgeInsets.only(top: 5),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Text.rich(
                      TextSpan(
                        style: textStyleFont.copyWith(
                          fontSize: 16,
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
          ),
          if (_waitingSwapResponse)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0x60000000),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kBluedark2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                _waitingSwapResponse = false;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: kWhite,
                            ),
                          ),
                        ],
                      ),
                      _swapResult == null
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
                                        '${PxStrings.swapping} ${_controllerFrom.text} ${_tokens[_tokenFromIndex]} ${PxStrings.forText} ${_controllerTo.text} ${_tokens[1 - _tokenFromIndex]}',
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
                                      ),
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
                                    onPressed: () {
                                      _controllerFrom.text = "";
                                      _controllerTo.text = "";
                                      setState(() {
                                        _waitingSwapResponse = false;
                                        _swapResult = null;
                                      });
                                    },
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
                            )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  void _presentRamp() {
    Configuration configuration = Configuration();
    configuration.fiatCurrency = "EUR";
    configuration.fiatValue = "0";
    configuration.deepLinkScheme = "PXT";
    RampFlutter.showRamp(configuration, onPurchaseCreated, onRampFailed, onRampClosed);
  }

  void onPurchaseCreated(Purchase purchase, String token, String url) {}

  void onRampFailed() {}

  void onRampClosed() {}

  Widget buildPriceLine() {
    if (_tokenPriceInAVAX == 0) return Container();
    String value = _showPricePxtPerAVAX ? (1 / _tokenPriceInAVAX).toStringAsFixed(2) : _tokenPriceInAVAX.toDouble().toStringAsFixed(9);
    value += " ";
    value += _showPricePxtPerAVAX ? PxStrings.pxt2 : PxStrings.avax;
    value += " per ";
    value += _showPricePxtPerAVAX ? PxStrings.avax : PxStrings.pxt2;
    return Column(
      children: [
        const SizedBox(height: 5),
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
                Text(
                  value,
                  style: textStyleColor.copyWith(
                    color: kGray,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(5),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                  iconSize: 15,
                  onPressed: () {
                    setState(() {
                      _showPricePxtPerAVAX = !_showPricePxtPerAVAX;
                    });
                  },
                  icon: const Icon(
                    Icons.sync,
                    color: kGray,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5)
      ],
    );
  }

  void onFromAmountChanged() {
    if (!_focusFrom.hasFocus) return;
    if (_controllerFrom.text.isNotEmpty) {
      onAmountChanged(_tokenFromIndex, double.parse(_controllerFrom.text));
      _controllerTo.text = _swapAmounts[_tokens[1 - _tokenFromIndex]].toString();
    } else {
      _controllerTo.text = "";
    }
  }

  void onToAmountChanged() {
    if (!_focusTo.hasFocus) return;
    if (_controllerTo.text.isNotEmpty) {
      onAmountChanged(1 - _tokenFromIndex, double.parse(_controllerTo.text));
      _controllerFrom.text = _swapAmounts[_tokens[_tokenFromIndex]].toString();
    } else {
      _controllerFrom.text = "";
    }
  }

  void onAmountChanged(int tokenIndex, double amount) {
    _swapAmounts[_tokens[tokenIndex]] = amount;
    _swapAmounts[_tokens[1 - tokenIndex]] = amount * (pow(_tokenPriceInAVAX, -1 + 2 * tokenIndex));
    _estimatedIndex = 1 - tokenIndex;
    setState(() {});
  }

  bool isSwappable() {
    return _swapAmounts[_tokens[_tokenFromIndex]] != null && _balances[_tokens[_tokenFromIndex]] != null && _swapAmounts[_tokens[_tokenFromIndex]]! > 0 && _swapAmounts[_tokens[_tokenFromIndex]]! <= _balances[_tokens[_tokenFromIndex]]!;
  }

  void confirmSwap() {
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(barrierDismissible: false, context: context, builder: (context) => SwapConfirmDialog(onYes: () => processSwap(), onNo: () {}));
  }

  void processSwap() {
    setState(() {
      _waitingSwapResponse = true;
    });
    if (_tokenFromIndex == 0) {
      _walletAccount.swapAVAXForTokens(amount: double.parse(_controllerFrom.text)).then((value) {
        print("============= Swap Result ============");
        print(value);
        if (value != null) {
          setState(() {
            _swapResult = value;
          });
          const String url = "https://api.avax-test.network/ext/bc/C/rpc";
          final web3client = Web3Client(url, Client());
          web3client.getTransactionReceipt(value).then((receiptValue) {
            print("============ Receipt Value ===========");
            print(receiptValue);
          });
          AppBloc.accountBloc.add(AccountBalanceRefreshEvent());
        } else {
          ToastUtil.makeToast("Error occurred. Try again later");
          setState(() {
            _waitingSwapResponse = false;
          });
        }
      });
    } else {
      _walletAccount.swapTokenForAVAX(amount: double.parse(_controllerFrom.text)).then((value) {
        print("============= Swap Result ============");
        print(value);
        if (value != null) {
          setState(() {
            _swapResult = value;
          });
          AppBloc.accountBloc.add(AccountBalanceRefreshEvent());
        } else {
          ToastUtil.makeToast("Error occurred. Try again later");
          setState(() {
            _waitingSwapResponse = false;
          });
        }
      });
    }
  }
}

class ButtonsAprove extends StatefulWidget {

  final WalletAccount walletAccount;
  final VoidCallback onSwap;

  const ButtonsAprove({Key? key, required this.walletAccount, required this.onSwap}) : super(key: key);

  @override
  _ButtonsAproveState createState() => _ButtonsAproveState();
}

class _ButtonsAproveState extends State<ButtonsAprove> {
  bool enableButton1 = true;
  bool enableButton2 = false;
  bool approved = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    widget.walletAccount.allowance().then((value) {
      setState(() {
        approved = value;
      });
    });
  }

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
                onPressed: () async {
                  if (!approved) {
                    loading = true;
                    setState(() {});
                    bool approved = await widget.walletAccount.approve();
                    loading = false;
                    approved = approved;
                    enableButton2 = true;
                    setState(() {});
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
                              : PxStrings.approveSwap,
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
                onPressed: () => widget.onSwap(),
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
