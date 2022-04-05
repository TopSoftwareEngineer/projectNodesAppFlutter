import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/router/router_path.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/ui/screens/node_wallet/cubit/nodewallet_cubit.dart';
import 'package:projectx/utils/toast_util.dart';

class NodeWalletScreen extends StatelessWidget {
  NodeWalletScreen({Key? key}) : super(key: key);
  final TextEditingController textEditingControllerNameWalletKey =
      TextEditingController();
  final TextEditingController textEditingControllerNameWalletPhrase =
      TextEditingController();
  final TextEditingController textEditingControllerPrivateKey =
      TextEditingController();
  final TextEditingController textEditingControllerPhrase =
      TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodewalletCubit(),
      child: BlocBuilder<NodewalletCubit, NodewalletState>(
        builder: (context, state) {
          NodewalletCubit _cubit = BlocProvider.of<NodewalletCubit>(context);
          if (state is LoadedVarsLocalStorage) {
            if (state.success) {
              _cubit.authenticatePublicKey();
            } else {
              ToastUtil.makeToast(state.message);
            }
          }
          if (state is LoadedAuthenticatePublicKey) {
            ToastUtil.makeToast(state.message);
            if (state.success) {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamed(
                  PxPathCfg.homeScreenPageRoute,
                );
              });
            }
          }
          return DefaultTabController(
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
              body: TabBarView(
                children: [
                  FormNode(
                    context: context,
                    textEditingControllerInput1:
                        textEditingControllerNameWalletKey,
                    textEditingControllerInput2:
                        textEditingControllerPrivateKey,
                    cubit: _cubit,
                    formKey: _formKey1,
                  ),
                  FormNode(
                    context: context,
                    textEditingControllerInput1:
                        textEditingControllerNameWalletPhrase,
                    textEditingControllerInput2: textEditingControllerPhrase,
                    cubit: _cubit,
                    formKey: _formKey2,
                    phrase: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FormNode extends StatefulWidget {
  final BuildContext context;
  final TextEditingController textEditingControllerInput1;
  final TextEditingController textEditingControllerInput2;
  final NodewalletCubit cubit;
  final GlobalKey<FormState> formKey;
  final bool phrase;
  const FormNode({
    Key? key,
    required this.context,
    required this.textEditingControllerInput1,
    required this.textEditingControllerInput2,
    required this.cubit,
    required this.formKey,
    this.phrase = true,
  }) : super(key: key);

  @override
  State<FormNode> createState() => _FormNodeState();
}

class _FormNodeState extends State<FormNode> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: widget.formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: widget.textEditingControllerInput1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Wallet 3',
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
              },
              onChanged: (valor) {},
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: widget.textEditingControllerInput2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Phrase',
                labelText: 'Phrase',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (!widget.phrase) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  if (value.length != 64) {
                    return PxStrings.validation64Characters;
                  }
                } else {
                  if (value!.isEmpty) {
                    return '';
                  } else {
                    List listPharse = value.split(' ');
                    if (listPharse.length != 12) {
                      return PxStrings.validation12Words;
                    }
                  }
                }
              },
              onChanged: (valor) {},
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              PxStrings.tapBarDesc,
              style: textStyleFontLightGray,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kBlueDark),
                ),
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    if (widget.phrase) {
                      widget.cubit.validateLocalStorageByPhrase(
                        walletName: widget.textEditingControllerInput1.text,
                        phrase: widget.textEditingControllerInput2.text
                            .toLowerCase(),
                      );
                    } else {
                      widget.cubit.validateLocalStorage(
                        walletName: widget.textEditingControllerInput1.text,
                        privateKey: widget.textEditingControllerInput2.text,
                      );
                    }
                  }
                },
                child: const Text(
                  PxStrings.textButton,
                  style: textStyleFont,
                ),
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  PxStrings.textFooter,
                  style: textStyleFontLightBlue,
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
