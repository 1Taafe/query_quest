import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/home_feature.dart';
import 'features/login/login_feature.dart';
import 'features/signup/signup_feature.dart';
import 'features/createOlympics/create_olympics_feature.dart';

import 'repositories/olympics/OlympicsRepository.dart';
import 'repositories/shared_prefs/shared_preferences.dart';
import 'repositories/auth/AuthRepository.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (_) => LoginBloc()..add(CheckTokenEvent())),
      BlocProvider<SignupBloc>(create: (_) => SignupBloc(AuthRepository())),
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<OlympicsBloc>(create: (_) => OlympicsBloc(OlympicsRepository(), SharedPrefs())),
      BlocProvider<CreateOlympicsBloc>(create: (_) => CreateOlympicsBloc()),
    ],
    child: QueryQuestApp(),
  ));
}

class QueryQuestApp extends StatelessWidget {
  const QueryQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Query Quest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => UserHomeScreen(),
        '/createOlympics': (context) => CreateOlympicsScreen(),
      },
    );
  }
}
