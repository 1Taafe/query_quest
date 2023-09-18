import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/organizer/home/organizer_home_feature.dart';

class OrganizerHomeScreen extends StatefulWidget {
  const OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizerHomeBloc, OrganizerHomeState>(
        builder: (context, state){
          if(state is OrganizerDefaultState){
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
                        BlocProvider.of<OrganizerHomeBloc>(context).add(OrganizerLogoutEvent());
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
                          ],
                        ),
                      )
                    ],
                  ),
                )
            );
          }
          if(state is OrganizerLogoutState){
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
          if(state is GetOrganizerProfileState){
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
                        BlocProvider.of<OrganizerHomeBloc>(context).add(OrganizerLogoutEvent());
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
          else if(state is OrganizerErrorHomeState){
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
                        BlocProvider.of<OrganizerHomeBloc>(context).add(OrganizerLogoutEvent());
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
          if(state is OrganizerLogoutState){
            Navigator.pop(context);
          }
        });
  }
}
