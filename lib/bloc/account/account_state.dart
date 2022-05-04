import 'package:meta/meta.dart';
import 'package:projectx/utils/web3/wallet_account.dart';

@immutable
abstract class AccountState {}

class AccountInitialState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountEmptyState extends AccountState {}

class AccountLoadedState extends AccountState {
  final WalletAccount account;

  AccountLoadedState({required this.account});
}

class AccountImportingState extends AccountState {}

class AccountImportFailedState extends AccountState {
  final String error;

  AccountImportFailedState({required this.error});
}

class AccountRefreshingState extends AccountState {}