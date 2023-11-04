import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/olympics/view/olympics_screen.dart';

import 'global/auth/auth_feature.dart';
import 'features/editOlympics/edit_olympics_feature.dart';
import 'features/home/home_feature.dart';
import 'features/login/login_feature.dart';
import 'features/signup/signup_feature.dart';
import 'features/createOlympics/create_olympics_feature.dart';
import 'features/olympics/olympics_feature.dart';

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
      BlocProvider<HomeOlympicsBloc>(create: (_) => HomeOlympicsBloc(OlympicsRepository(), SharedPrefs())),
      BlocProvider<CreateOlympicsBloc>(create: (_) => CreateOlympicsBloc(OlympicsRepository(), SharedPrefs())),
      BlocProvider<EditOlympicsBloc>(create: (_) => EditOlympicsBloc()),
      BlocProvider<OlympicsBloc>(create: (_) => OlympicsBloc()),
      BlocProvider<TaskBloc>(create: (_) => TaskBloc()),
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
        '/home': (context) => context.read<AuthBloc>().state is AuthorizedState ? HomeScreen() : LoginScreen(),
        '/createOlympics': (context) => context.read<AuthBloc>().state is AuthorizedState ? CreateOlympicsScreen() : LoginScreen(),
        '/editOlympics': (context){
          if(context.read<AuthBloc>().state is AuthorizedState && context.read<EditOlympicsBloc>().state is! EditOlympicsEmptyState){
            return EditOlympicsScreen();
          }
          else{
            return NotFoundScreen();
          }
        },
        '/olympics': (context){
          if(context.read<AuthBloc>().state is AuthorizedState && context.read<OlympicsBloc>().state is! OlympicsEmptyState){
            return OlympicsScreen();
          }
          else{
            return NotFoundScreen();
          }
        },
      },
    );
  }
}
