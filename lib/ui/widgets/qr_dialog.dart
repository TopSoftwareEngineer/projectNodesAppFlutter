import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectx/utils/toast_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDialog extends StatefulWidget {
  final String? data;

  const QrDialog({Key? key, this.data}) : super(key: key);

  @override
  _QrDialogState createState() => _QrDialogState();
}

class _QrDialogState extends State<QrDialog> {

  final String defData = "wc:865551c2-27e8-4e04-bf8d-3db5339a150d@1?bridge=https%3A%2F%2Fh.bridge.walletconnect.org&key=28b4cfbbadf34c101935d1b591f103193b3663faa86004b160aa318708bd4ed5";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: widget.data ?? defData));
          ToastUtil.makeToast("Copied to clipboard");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset("assets/images/LogoMasters/walletconnect.png", width: 80, height: 80,),
              const SizedBox(height: 16,),
              const Text(
                "Scan QR code with a WalletConnect-compatible wallet",
                style: TextStyle(fontSize: 14, color: Color(0xFFA2A1A6), fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              QrImage(
                data: widget.data ?? defData,
                padding: const EdgeInsets.all(0),
              ),
              const SizedBox(
                height: 28,
              ),
              const Text(
                "Copy to clipboard",
                style: TextStyle(fontSize: 14, color: Color(0xFFA2A1A6)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
