import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/createOlympics/bloc/create_olympics_bloc.dart';
import 'package:query_quest/features/createOlympics/bloc/create_olympics_event.dart';
import 'package:query_quest/features/createOlympics/bloc/create_olympics_state.dart';
import 'package:query_quest/features/home/olympicsBloc/OlympicsBloc.dart';
import 'package:query_quest/features/home/olympicsBloc/OlympicsEvent.dart';
import 'package:query_quest/features/home/olympicsBloc/OlympicsState.dart';
import '../../../repositories/models/Role.dart';
import '../home_feature.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  void initState() {
    setState(() {
      _selectedIndex = 0;
      BlocProvider.of<OlympicsBloc>(context).add(GetPlannedOlympicsEnvent());
    });
    super.initState();
  }

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
          else if(state is DefaultOrganizerState){
            return Scaffold(
              body: SafeArea(
                child: Row(
                  children: <Widget>[
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      groupAlignment: -1,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if(index == 0){
                            BlocProvider.of<OlympicsBloc>(context).add(GetPlannedOlympicsEnvent());
                          }
                          else if(index == 1){
                            BlocProvider.of<OlympicsBloc>(context).add(GetCurrentOlympicsEnvent());
                          }
                          else if(index == 2){
                            BlocProvider.of<OlympicsBloc>(context).add(GetFinishedOlympicsEnvent());
                          }
                        });
                      },
                      labelType: labelType,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PopupMenuButton(
                            offset: const Offset(100, 0),
                            tooltip: 'Профиль',
                            icon: Icon(Icons.account_circle_outlined),
                            iconSize: 48,
                            onSelected: (value) {
                              if(value == '/logout'){
                                BlocProvider.of<HomeBloc>(context).add(LogoutEvent());
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 8,),
                                        Text(
                                          "${state.currentUser.name} ${state.currentUser.surname}",
                                          style: TextStyle(
                                              fontSize: 18,
                                            color: Colors.black
                                          ),
                                        ),
                                        Text(
                                          "${state.currentUser.email}",
                                          style: TextStyle(
                                              fontSize: 16
                                          ),
                                        ),
                                        Text(
                                          state.currentUser.role == Role.Organizer ? 'Организатор' : 'Неизвестная роль',
                                          style: TextStyle(
                                              fontSize: 14
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                      ],
                                    ),
                                  ),
                                  enabled: false,
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.exit_to_app),
                                      SizedBox(width: 16,),
                                      Text('Выйти')
                                    ],
                                  ),
                                  value: '/logout',
                                ),
                              ];
                            },
                          ),
                          SizedBox(height: 32,),
                          FloatingActionButton(
                            elevation: 0,
                            onPressed: () {
                              Navigator.pushNamed(context, '/createOlympics');
                            },
                            child: const Icon(Icons.add),
                          ),
                          SizedBox(height: 32,),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        icon: const Icon(Icons.more_horiz_rounded),
                      ),
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                          icon: Icon(Icons.watch_later_outlined),
                          selectedIcon: Icon(Icons.watch_later),
                          label: Text(
                            'Запланированные',
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.assignment_outlined),
                          selectedIcon: Icon(Icons.assignment),
                          label: Text('Текущие'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.done),
                          selectedIcon: Icon(Icons.done_all),
                          label: Text('Завершенные'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    // This is the main content.
                    BlocConsumer<OlympicsBloc, OlympicsState>(
                        builder: (context, olympicsState){
                          if(olympicsState is DefaultOlympicsState){
                            return Expanded(
                              child: Container(
                                padding: EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Олимпиады',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 48
                                          ),
                                        ),
                                        padding: EdgeInsets.all(12),
                                      ),
                                      Container(
                                        height: 400,
                                        child: ListView.builder(
                                            itemCount: olympicsState.olympics.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context, int index){
                                              final olympics = olympicsState.olympics[index];
                                              return Container(
                                                margin: EdgeInsets.only(right: 32),
                                                child: InkWell(
                                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                  splashColor: Theme.of(context).colorScheme.primary,
                                                  onTap: () {

                                                  },
                                                  child: Card(
                                                    child: Container(
                                                        width: 360,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              height: 220.0,
                                                              width: 320.0,
                                                              decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: NetworkImage(olympics.image!),
                                                                  fit: BoxFit.fill,
                                                                ),
                                                                shape: BoxShape.rectangle,
                                                                borderRadius: BorderRadius.all(Radius.circular(8))
                                                              ),
                                                            ),
                                                            SizedBox(height: 24,),
                                                            Text(
                                                                olympics.name!,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 20
                                                              ),
                                                            ),
                                                            SizedBox(height: 16,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                    Icons.start
                                                                ),
                                                                SizedBox(width: 8,),
                                                                Text('Начало: ${olympics.getFormattedStartDate()}'),
                                                              ],
                                                            ),
                                                            SizedBox(height: 4,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.block_flipped
                                                                ),
                                                                SizedBox(width: 8,),
                                                                Text('Завершение: ${olympics.getFormattedEndDate()}')
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                )
                                              );
                                            }
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
                          }
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        listener: (context, olympicsState){
                          if(olympicsState is DefaultOlympicsState){

                          }
                        })
                  ],
                ),
              ),
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
