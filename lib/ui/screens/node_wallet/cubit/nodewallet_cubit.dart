import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/data/repositories/login_repository.dart';
import 'package:projectx/data/repositories/web3_repository.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';

part 'nodewallet_state.dart';

class NodewalletCubit extends Cubit<NodewalletState> {
  NodewalletCubit() : super(NodewalletInitial());
  final LoginRepository loginRepository = LoginRepository();
  final Web3Repository web3Repository = Web3Repository();

  void validateLocalStorage({
    required String walletName,
    required String privateKey,
  }) async {
    final result = SharedPreferencesUtil.getString('privateKey');
    bool success;
    String message = '';
    if (result == null || result != privateKey) {
      final credentials = await web3Repository.getCredentialsByPrivateKey(
        privateKey: privateKey,
      );
      final address = credentials.address;
      final publicKey = address.hexEip55;
      await SharedPreferencesUtil.removeAllItem();
      await SharedPreferencesUtil.saveString('privateKey', privateKey);
      await SharedPreferencesUtil.saveString(privateKey, publicKey);
      await SharedPreferencesUtil.saveString(publicKey, walletName);

      await SharedPreferencesUtil.saveString('privateKeyLast', privateKey);
      await SharedPreferencesUtil.saveString('publicKeyLast', publicKey);

      success = true;
    } else {
      final publicKey = SharedPreferencesUtil.getString(privateKey);
      final walletName = SharedPreferencesUtil.getString(publicKey!);
      success = false;
      message = '${PxStrings.existSamePrivateKey} $walletName';
    }
    emit(
      LoadedVarsLocalStorage(
        success: success,
        message: message,
      ),
    );
  }

  void validateLocalStorageByPhrase({
    required String walletName,
    required String phrase,
  }) async {
    final result = SharedPreferencesUtil.getString('phrase');
    bool success;
    String message = '';
    if (result == null || result != phrase) {
      await SharedPreferencesUtil.removeAllItem();
      await SharedPreferencesUtil.saveString('phrase', phrase);
      await SharedPreferencesUtil.saveString(phrase, walletName);
      success = true;
    } else {
      final phrase = SharedPreferencesUtil.getString('phrase');
      final walletName = SharedPreferencesUtil.getString(phrase!);
      success = false;
      message = '${PxStrings.existSamePhrase} $walletName';
    }
    emit(
      LoadedVarsLocalStorage(
        success: success,
        message: message,
      ),
    );
  }

  void authenticatePublicKey() async {
    bool success = false;
    String message;
    final privateKey = SharedPreferencesUtil.getString('privateKey');
    final publicKey = SharedPreferencesUtil.getString(privateKey!);
    final result = await loginRepository.authenticateKeyUser(
      key: publicKey!,
    );
    if (result.keys.first == 200) {
      success = true;
      String token;
      final list = result.values.first.split(':');
      token = list[1].replaceAll('"', '');
      token = token.replaceAll('}', '');
      await SharedPreferencesUtil.saveString('token', token);
      message = PxStrings.successfulImport;
    } else {
      message = result.values.first;
    }
    emit(
      LoadedAuthenticatePublicKey(
        success: success,
        message: message,
      ),
    );
  }
}
