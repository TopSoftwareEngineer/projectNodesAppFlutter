import 'package:flutter/material.dart';
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';

class FormWalletImport extends StatefulWidget {

  final bool isPhrase;

  const FormWalletImport({Key? key, this.isPhrase = true}) : super(key: key);

  @override
  State<FormWalletImport> createState() => _FormWalletImportState();
}

class _FormWalletImportState extends State<FormWalletImport> {

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerPhrase = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerPhrase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _controllerTitle,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Wallet Title',
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _controllerPhrase,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: widget.isPhrase ? 'Phrase' : 'Private Key',
                labelText: widget.isPhrase ? 'Phrase' : 'Private Key',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (!widget.isPhrase) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  if (value.length != 64) {
                    return PxStrings.validation64Characters;
                  }
                  return null;
                } else {
                  if (value!.isEmpty) {
                    return '';
                  } else {
                    List listPhrases = value.split(' ');
                    if (listPhrases.length != 12) {
                      return PxStrings.validation12Words;
                    } else {
                      return null;
                    }
                  }
                }
              },
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
                  if (formKey.currentState!.validate()) {
                    if (widget.isPhrase) {
                      AppBloc.accountBloc.add(AccountImportByPhraseEvent(title: _controllerTitle.text, phrase: _controllerPhrase.text));
                    } else {
                      AppBloc.accountBloc.add(AccountImportByPrivateKeyEvent(title: _controllerTitle.text, privateKey: _controllerPhrase.text));
                    }
                  }
                },
                child: const Text(
                  PxStrings.textButton,
                  style: textStyleFont,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              PxStrings.textFooter,
              textAlign: TextAlign.center,
              style: textStyleFontLightBlue,
            )
          ],
        ),
      ),
    );
  }
}
