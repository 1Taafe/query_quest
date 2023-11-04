import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:query_quest/features/olympics/olympics_feature.dart';
import 'package:query_quest/features/olympics/widgets/task_view.dart';

import '../bloc/olympics_bloc.dart';

class AvailableOlympicsView extends StatefulWidget {
  const AvailableOlympicsView({super.key});

  @override
  State<AvailableOlympicsView> createState() => _AvailableOlympicsViewState();
}

class _AvailableOlympicsViewState extends State<AvailableOlympicsView> {

  @override
  Widget build(BuildContext context) {
    final state = context.read<OlympicsBloc>().state as OlympicsAvailableState;
    int endTime = state.olympics.endDateTime!.subtract(Duration(hours: 3)).millisecondsSinceEpoch;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
        title: CountdownTimer(
          endTime: endTime,
          onEnd: (){
            if(!DateTime.now().add(Duration(hours: 3)).isAfter(state.olympics.endDateTime!)){
              Future.delayed(Duration(seconds: 1)).then((value){
                context.read<OlympicsBloc>().add(OlympicsLoadEvent(state.olympics.id!));
              });
            }
          },
          widgetBuilder: (_, CurrentRemainingTime? time) {
            if (time == null) {
              if(!DateTime.now().add(Duration(hours: 3, seconds: 2)).isBefore(state.olympics.endDateTime!)){
                return Text('Олимпиада завершена');
              }
              else{
                return Text('Олимпиада началась');
              }
            }
            else{
              String days = ' ${time.days} д.';
              String hours = ' ${time.hours} ч.';
              String minutes = ' ${time.min} мин.';
              String seconds = ' ${time.sec} с.';
              String message = 'До завершения${time.days == null ? '' : days}${time.hours == null ? '' : hours}${time.min == null ? '' : minutes}${time.sec == null ? '' : seconds}';
              return Text(
                message,
                style: TextStyle(
                  fontSize: 20
                ),
              );
            }
          },
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: (){
              showGeneralDialog(
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                    backgroundColor: Colors.black87,
                    body: Scaffold(
                        appBar: AppBar(
                          title: Text('Скрипт создания базы данных'),
                        ),
                        body: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            width: 1000,
                            child: SelectableText(state.olympics.databaseScript!),
                          ),
                        )
                    )
                ),
              );
            },
            label: Text('Схема БД'),
            icon: Icon(Icons.schema_outlined),
          ),
          SizedBox(width: 16,)
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
                child:
                Container(
                  height: 56,
                  color: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.tasks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        width: 86,
                        margin: EdgeInsets.fromLTRB(8, 2, 0, 10),
                        child: ElevatedButton(
                            onPressed: (){
                              context.read<TaskBloc>().add(TaskLoadEvent(state.tasks[index].id!, index + 1));
                            },
                            child: Text('${index+1}')
                        ),
                      );
                    },
                  ),
                )
            ),
            TaskView(),
          ],
        ),
      )
    );
  }
}
