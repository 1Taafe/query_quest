import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/editOlympics/edit_olympics_feature.dart';
import 'package:query_quest/global/auth/bloc/auth_event.dart';

import 'features/home/home_feature.dart';
import 'features/login/login_feature.dart';
import 'features/signup/signup_feature.dart';
import 'features/createOlympics/create_olympics_feature.dart';

import 'global/auth/bloc/auth_bloc.dart';
import 'global/auth/bloc/auth_state.dart';
import 'repositories/olympics/OlympicsRepository.dart';
import 'repositories/shared_prefs/shared_preferences.dart';
import 'repositories/auth/AuthRepository.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(create: (_) => AuthBloc()..add((TokenEvent()))),
      BlocProvider<SignupBloc>(create: (_) => SignupBloc(AuthRepository())),
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<OlympicsBloc>(create: (_) => OlympicsBloc(OlympicsRepository(), SharedPrefs())),
      BlocProvider<CreateOlympicsBloc>(create: (_) => CreateOlympicsBloc(OlympicsRepository(), SharedPrefs())),
      BlocProvider<EditOlympicsBloc>(create: (_) => EditOlympicsBloc()),
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ru'),
      ],
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
        '/home': (context) => BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnauthorizedState) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
          child: HomeScreen(),
        ),
        '/createOlympics': (context) => BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnauthorizedState) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
          child: CreateOlympicsScreen(),
        ),
        '/editOlympics': (context) => BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnauthorizedState) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
          child: EditOlympicsScreen(),
        ),
      },
    );
  }
}
