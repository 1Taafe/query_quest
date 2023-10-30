import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/editOlympics/edit_olympics_feature.dart';
import 'package:query_quest/global/auth/bloc/auth_event.dart';
import 'package:query_quest/global/auth/view/not_found_screen.dart';

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
      // onGenerateRoute: (settings) {
      //   if (settings.name == "/home") {
      //     return PageRouteBuilder(
      //         settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
      //         pageBuilder: (_, __, ___) => HomeScreen(),
      //         transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c)
      //     );
      //   }
      //   // Unknown route
      //   return MaterialPageRoute(builder: (_) => NotFoundScreen());
      // },
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
      },
    );
  }
}
