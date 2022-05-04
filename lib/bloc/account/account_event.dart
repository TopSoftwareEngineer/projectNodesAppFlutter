import 'package:meta/meta.dart';

@immutable
abstract class AccountEvent {}

class AccountLoadEvent extends AccountEvent {}

class AccountImportByPhraseEvent extends AccountEvent {
  final String title, phrase;

  AccountImportByPhraseEvent({required this.title, required this.phrase});
}

class AccountImportByPrivateKeyEvent extends AccountEvent {
  final String title, privateKey;

  AccountImportByPrivateKeyEvent({required this.title, required this.privateKey});
}

class AccountBalanceRefreshEvent extends AccountEvent {}

class AccountLogoutEvent extends AccountEvent {}

class AccountCreateNodesEvent extends AccountEvent {
  final int amount;

  AccountCreateNodesEvent({required this.amount});
}

class AccountClaimRewardEvent extends AccountEvent {
  final BigInt amount;

  AccountClaimRewardEvent({required this.amount});
}