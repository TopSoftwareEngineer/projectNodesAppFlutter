import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/bloc/bloc.dart';

class AppBloc {
  static final applicationBloc = ApplicationBloc();
  static final accountBloc = AccountBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(create: (context) => applicationBloc),
    BlocProvider<AccountBloc>(create: (context) => accountBloc),
  ];

  static void dispose() {
    applicationBloc.close();
    accountBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();
  factory AppBloc() {
    return _instance;
  }
  AppBloc._internal();
}