import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationLoadingState()){
    on((ApplicationStartEvent event, emit) => _mapApplicationStartEventToState(event, emit));
  }

  void _mapApplicationStartEventToState(ApplicationStartEvent event, emit) async {
    /// Init preferences
    await SharedPreferencesUtil.init();

    /// Load account
    AppBloc.accountBloc.add(AccountLoadEvent());

    emit(ApplicationLoadedState());
  }
}