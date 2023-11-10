import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

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
    final lastAnswer = state.result.lastAnswerTime!;
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
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state.olympics.image!,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined),
                          )
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
              SizedBox(height: 16,),
              Visibility(
                visible: state.olympics.isFinished! && state.result.userId != -1,
                  child: Row(
                    children: [
                      SizedBox(width: 32,),
                      Text(
                        'Результаты',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 36
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
              ),
              SizedBox(height: 8,),
              Visibility(
                visible: state.olympics.isFinished! && state.result.userId != -1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Table(
                      border: TableBorder.all(
                          color: Colors.black12
                      ),
                      children: [
                        TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Место'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Количество баллов'),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text('Время последнего ответа')
                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                                        color: state.result.place! == 1 ? Color.fromRGBO(201, 176, 55, 1) : (state.result.place! == 2 ? Color.fromRGBO(215, 215, 215, 1) : (state.result.place! == 3 ? Color.fromRGBO(106, 56, 5, 1) : Theme.of(context).colorScheme.primary)),
                                        child: Row(
                                          children: [
                                            Visibility(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              visible: state.result.place! >= 1 && state.result.place! <= 3,
                                            ),
                                            SizedBox(width: 24,),
                                            Text(
                                              state.result.place.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(state.result.totalScore.toString()),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text('${lastAnswer.day.toString().padLeft(2, '0')}.${lastAnswer.month.toString().padLeft(2, '0')}.${lastAnswer.year} ${lastAnswer.hour.toString().padLeft(2, '0')}:${lastAnswer.minute.toString().padLeft(2, '0')}:${lastAnswer.second.toString().padLeft(2, '0')}'),
                              ),
                            ]
                        )
                      ],
                    ),
                  )
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
