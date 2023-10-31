import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:query_quest/features/editOlympics/bloc/edit_olympics_event.dart';

import '../olympics_feature.dart';

class UnavailableOlympicsView extends StatefulWidget {
  const UnavailableOlympicsView({super.key});

  @override
  State<UnavailableOlympicsView> createState() => _UnavailableOlympicsViewState();
}

class _UnavailableOlympicsViewState extends State<UnavailableOlympicsView> {
  bool isReloaded = false;

  @override
  Widget build(BuildContext context) {
    final state = context.read<OlympicsBloc>().state as OlympicsUnavailableState;
    int endTime = state.olympics.startDateTime!.subtract(Duration(hours: 3)).millisecondsSinceEpoch;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: Text('Олимпиада ${state.olympics.name}'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 260.0,
                    width: 360.0,
                    child: Hero(
                        tag: state.olympics.id!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                            state.olympics.image!,
                            fit: BoxFit.cover,
                          ),
                        )
                    ),
                  ),
                  SizedBox(width: 48,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Организатор: ${state.olympics.creator?.name} ${state.olympics.creator?.surname}",
                          ),
                          Text(
                            'Описание',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 36
                            ),
                          ),
                          Text(state.olympics.description!),
                          SizedBox(height: 8,),
                          Divider(),
                          SizedBox(height: 8,),
                          CountdownTimer(
                            endTime: endTime,
                            onEnd: () {
                              if(!DateTime.now().add(Duration(hours: 3)).isAfter(state.olympics.endDateTime!)){
                                Future.delayed(Duration(seconds: 1)).then((value){
                                  context.read<OlympicsBloc>().add(OlympicsLoadEvent(state.olympics.id!));
                                });
                              }
                            },
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              if (time == null) {
                                if(!DateTime.now().add(Duration(hours: 3)).isBefore(state.olympics.endDateTime!)){
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
                                String message = 'До начала${time.days == null ? '' : days}${time.hours == null ? '' : hours}${time.min == null ? '' : minutes}${time.sec == null ? '' : seconds}';
                                return Text(
                                  message,
                                );
                              }

                            },
                          ),
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 64,),
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
