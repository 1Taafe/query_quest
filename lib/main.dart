import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/login/login_feature.dart';
import 'package:query_quest/features/organizer/home/bloc/OrganizerHomeBloc.dart';
import 'package:query_quest/features/organizer/home/organizer_home_feature.dart';
import 'package:query_quest/features/signup/signup_feature.dart';
import 'package:query_quest/features/user/home/home_feature.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (_) => LoginBloc()..add(CheckTokenEvent())),
      BlocProvider<SignupBloc>(create: (_) => SignupBloc(AuthRepository())),
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<OrganizerHomeBloc>(create: (_) => OrganizerHomeBloc()),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => UserHomeScreen(),
        '/organizer/home': (context) => OrganizerHomeScreen(),
      },
    );
  }
}
