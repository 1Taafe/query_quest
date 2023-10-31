import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/models/Role.dart';
import '../../editOlympics/edit_olympics_feature.dart';
import '../../olympics/olympics_feature.dart';
import '../home_feature.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  int _selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      _selectedIndex = 1;
      BlocProvider.of<HomeOlympicsBloc>(context).add(GetOlympicsEvent('current'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<HomeBloc>().state as DefaultState;
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
                    BlocProvider.of<HomeOlympicsBloc>(context).add(GetOlympicsEvent('planned'));
                  }
                  else if(index == 1){
                    BlocProvider.of<HomeOlympicsBloc>(context).add(GetOlympicsEvent('current'));
                  }
                  else if(index == 2){
                    BlocProvider.of<HomeOlympicsBloc>(context).add(GetOlympicsEvent('finished'));
                  }
                });
              },
              labelType: labelType,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/bstu_logo.png',
                        width: 48,
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  SizedBox(height: 8,),
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
                          enabled: false,
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
                                  state.currentUser.role == Role.User ? 'Пользователь' : 'Неизвестная роль',
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(height: 8,),
                              ],
                            ),
                          ),
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
                  SizedBox(height: 8,),
                ],
              ),
              // trailing: IconButton(
              //   onPressed: () {
              //     // Add your onPressed code here!
              //   },
              //   icon: const Icon(Icons.more_horiz_rounded),
              // ),
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
            BlocConsumer<HomeOlympicsBloc, HomeOlympicsState>(
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
                                height: 420,
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
                                              // BlocProvider.of<EditOlympicsBloc>(context).add(LoadOlympicsEvent(olympics.id!, olympicsState.path));
                                              // Navigator.pushNamed(context, '/editOlympics');
                                              context.read<OlympicsBloc>().add(OlympicsLoadEvent(olympics.id!));
                                              Navigator.of(context).pushNamed('/olympics');
                                            },
                                            child: Card(
                                              child: Container(
                                                  width: 360,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 260.0,
                                                        width: 360.0,
                                                        child: Hero(
                                                            tag: olympics.id!,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                                              child: Image.network(
                                                                olympics.image!,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            )
                                                        ),
                                                      ),
                                                      SizedBox(height: 20,),
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
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          )
                                      );
                                    }
                                ),
                              ),
                            ],
                          )
                      ),
                    );
                  }
                  else if(olympicsState is EmptyOlympicsState){
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
                                child: Text('Мы не нашли для вас олимпиад :('),
                              ),
                              Divider(),
                            ],
                          )
                      ),
                    );
                  }
                  else{
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
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
}
