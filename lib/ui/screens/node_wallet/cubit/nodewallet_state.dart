part of 'nodewallet_cubit.dart';

@immutable
abstract class NodewalletState {}

class NodewalletInitial extends NodewalletState {}

class LoadedVarsLocalStorage extends NodewalletState {
  final bool success;
  final String message;

  LoadedVarsLocalStorage({
    required this.success,
    this.message = '',
  });
}

class LoadedAuthenticatePublicKey extends NodewalletState {
  final bool success;
  final String message;

  LoadedAuthenticatePublicKey({
    required this.success,
    required this.message,
  });
}
