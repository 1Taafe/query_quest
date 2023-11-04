import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/shared_widgets/show_shack_bar.dart';
import '../olympics_feature.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  final answerController = TextEditingController();
  final resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
        builder: (BuildContext context, TaskState state){
          if(state is TaskEmptyState){
            return Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                  'Выберите задание',
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            );
          }
          else if(state is TaskDefaultState){
            answerController.text = state.answer.query == null ? '' : state.answer.query!;
            resultController.text = state.answer.result == null ? '' : state.answer.result!;
            final time = state.answer.time;
            return Column(
              children: [
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 8,),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                                'Задание #${state.taskOrderId}',
                            ),
                            Text(
                              state.task.title!,
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    Spacer(),
                    Card(
                      color: state.answer.score == null ? Colors.amber : (state.answer.score == 0 ? Colors.red : Colors.lightGreen),
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: Colors.white,
                              ),
                              SizedBox(width: 16,),
                              Column(
                                children: [
                                  Text(
                                    state.answer.score == null ? 'Задание не выполнено' : (state.answer.score == 0 ? 'Задание выполнено неверно' : 'Верный ответ сохранен'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    ),
                                  ),
                                  Visibility(
                                    visible: state.answer.time != null,
                                      child: Text(
                                          '${time?.day.toString().padLeft(2, '0')}.${time?.month.toString().padLeft(2, '0')}.${time?.year} ${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}:${time?.second.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          color: Colors.white,
                                            fontSize: 16
                                        ),
                                      ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    ),
                    SizedBox(width: 8,),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      child: TextField(
                        maxLines: null,
                        controller: answerController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Решение')
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      child: TextField(
                        maxLines: null,
                        controller: resultController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Результат запроса')
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    Container(
                      height: 42,
                      width: 170,
                      child: FilledButton.icon(
                          onPressed: (){
                            context.read<TaskBloc>().add(TaskCheckEvent(state.taskOrderId, state.task.id!, answerController.text));
                          },
                          icon: Icon(Icons.bolt_rounded),
                          label: Text('Выполнить'),
                      ),
                    ),
                    SizedBox(width: 16,)
                  ],
                )
              ],
            );
          }
          else if(state is TaskLoadingState){
            return Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
            );
          }
          else{
            return Center(
              child: Text(':('),
            );
          }
        },
        listener: (BuildContext context, TaskState state){
          if(state is TaskErrorState){
            showStatusSnackbar(context, Colors.redAccent, Icons.error_outline, state.message);
          }
        }
    );
  }
}
