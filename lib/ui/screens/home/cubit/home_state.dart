part of 'home_cubit.dart';

// @immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadedlatestRoundData extends HomeState {
  final BigInt latestRoundData;

  LoadedlatestRoundData(this.latestRoundData);
}

class LoadedInitialData extends HomeState {
  final String publicKey;
  final List<Node> listNodes;
  final BigInt nodeNumberOf;
  final EtherAmount balanceOf;
  final BigInt rewardAmountOf;

  LoadedInitialData({
    required this.publicKey,
    required this.listNodes,
    required this.nodeNumberOf,
    required this.balanceOf,
    required this.rewardAmountOf,
  });
}

class LoadedCashoutAll extends HomeState {
  final Response response;
  final int seconds;

  LoadedCashoutAll({
    required this.response,
    required this.seconds,
  });
}

class LoadedCreateNodeWithTokens extends HomeState {
  final Response response;

  LoadedCreateNodeWithTokens({
    required this.response,
  });
}
