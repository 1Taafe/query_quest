import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/user/home/bloc/HomeBloc.dart';
import 'package:query_quest/features/user/home/bloc/HomeEvent.dart';
import 'package:query_quest/features/user/home/bloc/HomeState.dart';
import 'package:query_quest/features/user/home/widgets/DatabaseAlertDialog.dart';
import 'package:query_quest/repositories/models/Database.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state){
          if(state is DefaultState){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                leading: Hero(
                    tag: 'logo',
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.all(1),
                      child: Image.asset(
                        'assets/images/bstu_logo.png',
                        width: 24,
                      ),
                    )
                ),
                title: Text('Query Quest'),
                actions: [
                  ElevatedButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.account_circle_outlined),
                      label: Text('${state.currentUser.name!} ${state.currentUser.surname!}',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      )
                  ),
                  SizedBox(width: 4,),
                  TextButton.icon(
                    onPressed: (){
                      BlocProvider.of<HomeBloc>(context).add(LogoutEvent());
                    },
                    icon: Icon(
                        Icons.logout
                    ),
                    label: Text('Выйти'),
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    SizedBox(height: 16,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Container(
                              width: 400,
                              height: 116,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning_amber,
                                    size: 48,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 16,),
                                  Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Платформа в разработке. Если что-то не работает, мои полномочия тут все :)',
                                            overflow: TextOverflow.clip,
                                          ),
                                          Text(
                                            'Версия alpha 0.0.1 (ничего еще нет :D )'
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              ),
                            )
                          ),
                          SizedBox(width: 16,),
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              splashColor: Theme.of(context).colorScheme.onPrimary,
                              onTap: () {
                                showDialog(context: context, builder: (context) => DatabaseAlertDialog(state.currentUser.database!, state.currentUser));
                              },
                              child: Container(
                                width: 400,
                                height: 116,
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.offline_bolt_outlined,
                                      size: 48,
                                    ),
                                    SizedBox(width: 16,),
                                    Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'У вас есть возможность выбрать СУБД для выполнения заданий. \nНажмите чтобы изменить ваш выбор',
                                              overflow: TextOverflow.clip,
                                            ),
                                            Divider(),
                                            Text('Текущая СУБД: ${state.currentUser.database}')
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                        ],
                      ),
                    )
                  ],
                ),
              )
            );
          }
          if(state is LogoutState){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                leading: Hero(
                    tag: 'logo',
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/bstu_logo.png',
                        width: 24,
                      ),
                    )
                ),
                title: Text('QueryQuest Home'),
              ),
            );
          }
          if(state is GetUserProfileState || state is SetDatabaseState){
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                  leading: Hero(
                      tag: 'logo',
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/bstu_logo.png',
                          width: 24,
                        ),
                      )
                  ),
                  title: Text('QueryQuest Home'),
                  actions: [
                    TextButton.icon(
                      onPressed: (){
                        BlocProvider.of<HomeBloc>(context).add(LogoutEvent());
                      },
                      icon: Icon(
                          Icons.logout
                      ),
                      label: Text('Выйти'),
                    ),
                    SizedBox(
                      width: 16,
                    )
                  ],
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                )
            );
          }
          else if(state is ErrorHomeState){
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                  leading: Hero(
                      tag: 'logo',
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/bstu_logo.png',
                          width: 24,
                        ),
                      )
                  ),
                  title: Text('QueryQuest Home'),
                  actions: [
                    TextButton.icon(
                      onPressed: (){
                        BlocProvider.of<HomeBloc>(context).add(LogoutEvent());
                      },
                      icon: Icon(
                          Icons.logout
                      ),
                      label: Text('Выйти'),
                    ),
                    SizedBox(
                      width: 16,
                    )
                  ],
                ),
                body: Center(
                  child: Text('Что-то пошло не так :( \n ${state.status}'),
                )
            );
          }
          else{
            return Center();
          }
        },
        listener: (context, state){
          if(state is LogoutState){
            Navigator.pop(context);
          }
          else if(state is SetDatabaseState){

          }
        });
  }
}
