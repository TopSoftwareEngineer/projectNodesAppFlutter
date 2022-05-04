import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:projectx/bloc/app_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/themes.dart';
import 'package:projectx/ui/screens/home_navigationbar_screen.dart';
import 'package:projectx/ui/widgets/loading_window.dart';
import 'config/router/router.dart' as router;

import 'ui/screens/login/login_screen.dart';

class ProjectXApp extends StatefulWidget {
  const ProjectXApp({Key? key}) : super(key: key);

  @override
  State<ProjectXApp> createState() => _ProjectXAppState();
}

class _ProjectXAppState extends State<ProjectXApp> {

  @override
  void initState() {
    super.initState();
    AppBloc.applicationBloc.add(ApplicationStartEvent());
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppBloc.blocProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ProjectX',
          theme: PxAppTheme.initialTheme(),
          onGenerateRoute: router.generateRoute,
          home: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (applicationContext, applicationState) {
              if (applicationState is ApplicationLoadingState) return Container();
              return BlocBuilder<AccountBloc, AccountState>(
                  builder: (accountContext, accountState) {
                    if (accountState is AccountInitialState) {
                      return Container();
                    } else if (accountState is AccountEmptyState || accountState is AccountImportingState || accountState is AccountImportFailedState) {
                      FlutterNativeSplash.remove();
                      return const InitialScreen();
                    } else if (accountState is AccountLoadingState) {
                      FlutterNativeSplash.remove();
                      return const LoadingWidget();
                    } else {
                      FlutterNativeSplash.remove();
                      return const HomeBottomNavigationBarScreen();
                    }
                  },
              );
            },
          ),
        ));
  }
}
