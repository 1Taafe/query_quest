import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/signup/bloc/SignupEvent.dart';
import 'package:query_quest/features/signup/bloc/SignupState.dart';

import '../../../repositories/models/User.dart';
import '../bloc/SignupBloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController courseController = TextEditingController();
  int? selectedCourse = 1;
  int? selectedGroup = 1;
  bool agreement = false;
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<int> courses = <int>[1, 2, 3, 4];
  List<int> groups = <int>[1,2,3,4,5,6,7,8,9,10,11,12];

  @override
  Widget build(BuildContext context) {

    final List<DropdownMenuEntry<int>> courseEntries =
    <DropdownMenuEntry<int>>[];
    for (final int course in [1, 2, 3, 4]) {
      courseEntries.add(
        DropdownMenuEntry<int>(
            value: course, label: course.toString(), enabled: true),
      );
    }

    final List<DropdownMenuEntry<int>> groupEntries =
    <DropdownMenuEntry<int>>[];
    for (final int group in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) {
      groupEntries.add(
        DropdownMenuEntry<int>(
            value: group, label: group.toString(), enabled: true),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        builder: (context, state){
          if(state is FetchSignupState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Padding(
                    padding: EdgeInsets.all(24),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/bstu_logo.png',
                        width: 60,
                      ),
                    )
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 32,),
                      Container(
                        width: 540,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            DropdownMenu<int>(
                                label: Text('Курс'),
                                initialSelection: 1,
                                onSelected: (int? course) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    selectedCourse = course!;
                                  });
                                },
                                dropdownMenuEntries: courseEntries
                            ),
                            SizedBox(width: 22,),
                            DropdownMenu<int>(
                                label: Text('Группа'),
                                initialSelection: 1,
                                onSelected: (int? group) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    selectedGroup = group!;
                                  });
                                },
                                dropdownMenuEntries: groupEntries
                            ),
                            Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 24),
                                      child: Image.asset(
                                        'assets/images/fit_logo.png',
                                        width: 100,
                                      ),
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 540,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 262,
                              child: TextField(
                                controller: surnameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Фамилия',
                                ),
                              ),
                            ),
                            Container(
                              width: 262,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Имя',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 540,
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
                        width: 540,
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
                      SizedBox(height: 16,),
                      Container(
                        width: 540,
                        child: CheckboxListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          value: agreement,
                          onChanged: (bool? value) {
                            setState(() {
                              agreement = value!;
                            });
                          },
                          title: const Text('Персональные данные'),
                          subtitle: const Text('Даю согласие на обработку персональных данных в соответствии с Законом РБ от 7 мая 2021 г. №99-З «О защите персональных данных»'),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 48,
                        width: 240,
                        child: FilledButton(
                            onPressed: agreement ? (){
                              var user = User();
                              user.course = selectedCourse!;
                              user.group = selectedGroup!;
                              user.surname = surnameController.text;
                              user.name = nameController.text;
                              user.email = emailController.text;
                              user.password = passwordController.text;
                              BlocProvider.of<SignupBloc>(context).add(SignupUserEvent(user));
                            } : null,
                            child: Text('Зарегистрироваться'),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if(state is SuccessfulSignupState){
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
                        state.successMessage,
                      style: TextStyle(
                        fontSize: 18
                      )
                    ),
                  ],
                )
            ));
            Navigator.pop(context);
          }
          else if (state is ErrorSignupState){
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
                    state.errorMessage,
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ],
              )
            ));
          }
        },
      ),
    );
  }
}
