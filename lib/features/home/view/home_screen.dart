import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state){
          if(state is DefaultState){
            return const UserView();
          }
          else if(state is DefaultOrganizerState){
            return const OrganizerView();
          }
          else{
            NavigationRailLabelType labelType = NavigationRailLabelType.all;
            return Scaffold(
              body: SafeArea(
                child: Row(
                  children: <Widget>[
                    NavigationRail(
                      labelType: labelType,
                      selectedIndex: 0,
                      groupAlignment: -1,
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
                          SizedBox(height: 32,)
                        ],
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
                    Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                    )
                  ],
                ),
              ),
            );
          }
        },
        listener: (context, state){
          if(state is LogoutState){
            Navigator.pop(context);
          }
        });
  }
}
