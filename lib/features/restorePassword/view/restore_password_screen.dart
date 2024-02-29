import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:query_quest/features/restorePassword/bloc/restore_password_bloc.dart';
import 'package:query_quest/features/restorePassword/bloc/restore_password_event.dart';
import 'package:query_quest/features/restorePassword/bloc/restore_password_state.dart';

import '../../../shared_widgets/show_shack_bar.dart';

class RestorePasswordScreen extends StatefulWidget {
  const RestorePasswordScreen({super.key});

  @override
  State<RestorePasswordScreen> createState() => _RestorePasswordScreenState();
}

class _RestorePasswordScreenState extends State<RestorePasswordScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Восстановление пароля"),
        leading: IconButton(
          padding: EdgeInsets.all(16),
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            context.read<RestorePasswordBloc>().add(ResetRestorePasswordScreenEvent());
          },
        ),
      ),
      body: BlocConsumer<RestorePasswordBloc, RestorePasswordState>(
        builder: (context, state){
          if(state is DefaultRestorePasswordState){
            return Center(
              child: Container(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Для восстановления пароля необходима электронная почта, с помощью которой создавалась учетная запись. Далее на почту будет отправлен код, который используется для смены пароля"
                    ),
                    Gap(16),
                    Container(
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                        ),
                      ),
                    ),
                    Gap(16),
                    Container(
                      width: 220,
                      height: 40,
                      child: FilledButton(
                        onPressed: (){
                          context.read<RestorePasswordBloc>().add(RestorePasswordRequestEvent(emailController.text));
                        },
                        child: Text(
                          "Отправить письмо"
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          else if(state is EnterPasswordCodeState){
            return Center(
              child: Container(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: TextField(
                        enabled: false,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                        ),
                      ),
                    ),
                    Gap(16),
                    Container(
                      child: TextField(
                        controller: codeController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_lock_outlined),
                          border: OutlineInputBorder(),
                          labelText: 'Код из письма',
                        ),
                      ),
                    ),
                    Gap(16),
                    Text(
                        "Введите 6-ти значный код из письма для того чтобы сменить пароль"
                    ),
                    Gap(16),
                    Container(
                      width: 180,
                      height: 40,
                      child: FilledButton(
                        onPressed: (){
                          context.read<RestorePasswordBloc>().add(CheckRestoreCodeEvent(emailController.text, codeController.text));
                        },
                        child: Text(
                            "Проверить код"
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          else if(state is EnterNewPasswordState){
            return Center(
              child: Container(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: TextField(
                        enabled: false,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                        ),
                      ),
                    ),
                    Gap(16),
                    Container(
                      child: TextField(
                        controller: codeController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabled: false,
                          prefixIcon: Icon(Icons.mail_lock_outlined),
                          border: OutlineInputBorder(),
                          labelText: 'Код из письма',
                        ),
                      ),
                    ),
                    Gap(16),
                    Container(
                      child: TextField(
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_rounded),
                          border: OutlineInputBorder(),
                          labelText: 'Новый пароль',
                        ),
                      ),
                    ),
                    Gap(16),
                    Text(
                        "Введите новый пароль для вашей учетной записи. Пароль должен быть более 8 символов"
                    ),
                    Gap(16),
                    Container(
                      width: 180,
                      height: 40,
                      child: FilledButton(
                        onPressed: (){
                          context.read<RestorePasswordBloc>().add(ChangePasswordEvent(emailController.text, codeController.text, newPasswordController.text));
                        },
                        child: Text(
                            "Восстановить"
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          else if(state is LoadingRestorePasswordState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return Center(
              child: Text("Неизвестная ошибка"),
            );
          }
        },
        listener: (context, state){
          if(state is SuccessRestorePasswordState){
            showStatusSnackbar(context, Colors.green, Icons.check_circle_outline, state.message);
          }
          else if(state is ErrorRestorePasswordState){
            showStatusSnackbar(context, Colors.red, Icons.error_outline, state.message);
          }
          else if(state is SuccessChangePasswordState){
            Navigator.of(context).pop();
            context.read<RestorePasswordBloc>().add(ResetRestorePasswordScreenEvent());
          }
        },
      ),
    );
  }
}
