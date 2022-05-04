import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/api/api.dart';
import 'package:projectx/bloc/account/account_event.dart';
import 'package:projectx/bloc/account/account_state.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';
import 'package:projectx/utils/web3/wallet_account.dart';
import 'package:web3dart/web3dart.dart';


class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitialState()){
    on((AccountLoadEvent event, emit) => _mapAccountLoadEventToState(event, emit));
    on((AccountImportByPhraseEvent event, emit) => _mapAccountImportByPhraseEventToState(event, emit));
    on((AccountImportByPrivateKeyEvent event, emit) => _mapAccountImportByPrivateKeyEventToState(event, emit));
    on((AccountBalanceRefreshEvent event, emit) => _mapAccountBalanceRefreshEventToState(event, emit));
    on((AccountLogoutEvent event, emit) => _mapAccountLogoutEventToState(event, emit));
    on((AccountCreateNodesEvent event, emit) => _mapAccountCreateNodesEventToState(event, emit));
    on((AccountClaimRewardEvent event, emit) => _mapAccountClaimRewardEventToState(event, emit));
  }

  void _mapAccountLoadEventToState(AccountLoadEvent event, emit) async {
    emit(AccountLoadingState());
    // final privateKey = '29b079c9bd78cefd79647d52faeb58e5b5276bb77c3166d8d964550cb8593cd1';
    final privateKey = SharedPreferencesUtil.getString("privateKey");
    final token = SharedPreferencesUtil.getString("token");
    final title = SharedPreferencesUtil.getString("title");
    if (privateKey == null) {
      emit(AccountEmptyState());
    } else {
      WalletAccount account = WalletAccount(privateKey: privateKey, token: token, title: title);
      await account.load();
      emit(AccountLoadedState(account: account));
    }
  }

  void _mapAccountImportByPhraseEventToState(AccountImportByPhraseEvent event, emit) async {
    emit(AccountImportingState());
    final title = event.title;
    final phraseNew = event.phrase;
    final phraseSaved = SharedPreferencesUtil.getString('phrase');
    if (phraseSaved != null && phraseSaved == phraseNew) {
      emit(AccountImportFailedState(error: '${PxStrings.existSamePhrase} $title'));
    } else {

    }
  }

  void _mapAccountImportByPrivateKeyEventToState(AccountImportByPrivateKeyEvent event, emit) async {
    emit(AccountImportingState());
    final title = event.title;
    final privateKeyNew = event.privateKey;
    final privateKeySaved = SharedPreferencesUtil.getString('privateKey');
    if (privateKeySaved != null && privateKeySaved == privateKeyNew) {
      emit(AccountImportFailedState(error: '${PxStrings.existSamePrivateKey} $title'));
    } else {
      EthPrivateKey credentials = EthPrivateKey.fromHex(privateKeyNew);
      final authResult = await Api.authenticateWalletAddress(address: credentials.address.hex);
      String? token = authResult["token"];
      if (token != null) {
        /// finally we can import this wallet
        await SharedPreferencesUtil.saveString('token', token);
        await SharedPreferencesUtil.saveString('privateKey', privateKeyNew);
        await SharedPreferencesUtil.saveString('title', title);
        WalletAccount account = WalletAccount(privateKey: privateKeyNew, title: title, token: token);
        await account.load();
        emit(AccountLoadedState(account: account));
      } else {
        emit(AccountImportFailedState(error: 'Cannot authorize your address, please try again later'));
      }
    }
  }
  
  void _mapAccountBalanceRefreshEventToState(AccountBalanceRefreshEvent event, emit) async {
    WalletAccount account = (state as AccountLoadedState).account;
    emit(AccountRefreshingState());
    await account.loadBalances();
    emit(AccountLoadedState(account: account));
  }

  void _mapAccountLogoutEventToState(AccountLogoutEvent event, emit) async {
    await SharedPreferencesUtil.removeAllItem();
    emit(AccountEmptyState());
  }

  void _mapAccountCreateNodesEventToState(AccountCreateNodesEvent event, emit) async {
    WalletAccount account = (state as AccountLoadedState).account;
    int amount = event.amount;
    emit(AccountRefreshingState());
    String txHash = await account.createNodes(amount: amount);




    emit(AccountLoadedState(account: account));
  }

  void _mapAccountClaimRewardEventToState(AccountClaimRewardEvent event, emit) async {
    WalletAccount account = (state as AccountLoadedState).account;
    BigInt amount = event.amount;
    emit(AccountRefreshingState());

    await Future.delayed(Duration(seconds: 10));

    emit(AccountLoadedState(account: account));
  }
}