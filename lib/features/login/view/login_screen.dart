import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:query_quest/global/auth/bloc/auth_event.dart';

import '../../../global/auth/bloc/auth_bloc.dart';
import '../../../global/auth/bloc/auth_state.dart';
import '../../../repositories/models/User.dart';
import '../../home/home_feature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state){
          if(state is AuthLoadingState){
            return Stack(
              children: [
                Padding(
                    padding: EdgeInsets.all(24),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/bstu_logo.png',
                        width: 120,
                      ),
                    )
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Lottie.asset(
                            'assets/lottie/database2.json',
                            width: 320
                        ),
                      ),
                      VerticalDivider(
                        indent: 180,
                        endIndent: 180,
                      ),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'QueryQuest – олимпиады по базам данных',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'Вход',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                )
              ],
            );
          }
          else if(state is UnauthorizedState || state is UnauthorizedNotifyState || state is AuthorizedState || state is AuthorizedNotifyState){
            return Stack(
              children: [
                Padding(
                    padding: EdgeInsets.all(24),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/bstu_logo.png',
                        width: 120,
                      ),
                    )
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Lottie.asset(
                            'assets/lottie/database2.json',
                            width: 320
                        ),
                      ),
                      VerticalDivider(
                        indent: 180,
                        endIndent: 180,
                      ),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'QueryQuest – олимпиады по базам данных',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'Вход',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  width: 460,
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.alternate_email),
                                      border: OutlineInputBorder(),
                                      labelText: 'Электронная почта',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  width: 460,
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      border: OutlineInputBorder(),
                                      labelText: 'Пароль',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  height: 48,
                                  width: 180,
                                  child: FilledButton(
                                      onPressed: (){
                                        var user = User();
                                        user.email = emailController.text;
                                        user.password = passwordController.text;
                                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(user));
                                      },
                                      child: Text('Войти')
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  child: TextButton(
                                      onPressed: (){
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                      child: Text('Зарегистрироваться')
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                )
              ],
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        listener: (context, state){
          if(state is AuthorizedNotifyState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 16,),
                    Text(
                        state.status,
                        style: TextStyle(
                            fontSize: 18
                        )
                    ),
                  ],
                )
            ));
            if(ModalRoute.of(context)?.settings.name == '/'){
              Navigator.pushNamed(context, '/home');
            }
            BlocProvider.of<HomeBloc>(context).add(GetUserInfoEvent());
          }
          else if(state is UnauthorizedNotifyState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 16,),
                    Text(
                        state.status,
                        style: TextStyle(
                            fontSize: 18
                        )
                    ),
                  ],
                )
            ));
          }
        },
      )
    );
  }
}
