import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/home/home_feature.dart';
import '../../../repositories/models/Task.dart';
import '../../../shared_widgets/show_shack_bar.dart';
import '../edit_olympics_feature.dart';

class EditOlympicsScreen extends StatefulWidget {
  const EditOlympicsScreen({super.key});

  @override
  State<EditOlympicsScreen> createState() => _EditOlympicsScreenState();
}

class _EditOlympicsScreenState extends State<EditOlympicsScreen> {

  TextEditingController newTitleController = TextEditingController();
  TextEditingController newSolutionController = TextEditingController();
  TextEditingController queryController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditOlympicsBloc, EditOlympicsState>(
        builder: (context, state){
          if(state is EditOlympicsDefaultState){
            resultController.text = state.queryResult;
            final resultList = List<TableRow>.generate(state.results.length, (index){
              final result = state.results[index];
              return TableRow(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                                color: result.place! == 1 ? Color.fromRGBO(201, 176, 55, 1) : (result.place! == 2 ? Color.fromRGBO(215, 215, 215, 1) : (result.place! == 3 ? Color.fromRGBO(106, 56, 5, 1) : Theme.of(context).colorScheme.primary)),
                                child: Row(
                                  children: [
                                    Visibility(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 24,),
                                        ],
                                      ),
                                      visible: result.place! >= 1 && result.place! <= 3,
                                    ),
                                    Text(
                                      result.place.toString(),
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
                      child: Text(result.user!.surname!),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(result.user!.name!),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(result.user!.email!),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(result.user!.course.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(result.user!.group.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(result.totalScore.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('${result.lastAnswerTime!.day.toString().padLeft(2, '0')}.${result.lastAnswerTime!.month.toString().padLeft(2, '0')}.${result.lastAnswerTime!.year} ${result.lastAnswerTime!.hour.toString().padLeft(2, '0')}:${result.lastAnswerTime!.minute.toString().padLeft(2, '0')}:${result.lastAnswerTime!.second.toString().padLeft(2, '0')}'),
                    ),
                  ]
              );
            });
            resultList.insert(0, TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Место'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Фамилия'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Имя'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Email'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Курс'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Группа'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Количество баллов'),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Время последнего ответа'),
                ),
              ]
            ));
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                title: Text(state.olympics.name!),
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
                  SizedBox(width: 12,),
                  ElevatedButton.icon(
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(state.olympics.name!),
                          content: Container(
                            height: 200,
                            width: 340,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text('Вы действительно хотите удалить олимпиаду?'),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 0.5,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 56,
                                  child: TextButton.icon(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      context.read<EditOlympicsBloc>().add(DeleteOlympicsEvent(state.olympics, state.olympicsPath, state.tasks, state.results));
                                    },
                                    icon: Icon(Icons.delete_outline, color: Colors.redAccent,),
                                    label: Text('Удалить', style: TextStyle(color: Colors.redAccent),),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(0.0),
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 56,
                                  child: TextButton.icon(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close_outlined),
                                    label: Text('Оставить'),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                                            )
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                    ),
                    icon: Icon(Icons.delete_outline),
                    label: Text('Удалить'),
                  ),
                  SizedBox(width: 16,)
                ],
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
                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 48,),
                      Container(
                        child: Text(
                          'Задания (${state.tasks.length})',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 80,
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  label: Text('Новое задание'),
                                  border: OutlineInputBorder(),
                                ),
                                controller: newTitleController,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 80,
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  label: Text('Ответ на задание'),
                                  border: OutlineInputBorder(),
                                ),
                                controller: newSolutionController,
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  final task = Task();
                                  task.olympicsId = state.olympics.id;
                                  task.title = newTitleController.text;
                                  task.solution = newSolutionController.text;
                                  context.read<EditOlympicsBloc>().add(CreateTaskEvent(state.olympicsPath, task, state.tasks, state.olympics, state.results));
                                },
                                icon: Icon(Icons.add)
                            ),
                            IconButton(
                                onPressed: (){
                                  newTitleController.text = "";
                                  newSolutionController.text = "";
                                },
                                icon: Icon(Icons.cleaning_services_outlined)
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24,),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: ListView.builder(
                            itemCount: state.tasks.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              final task = state.tasks[index];
                              final titleController = TextEditingController();
                              final solutionController = TextEditingController();
                              titleController.text = task.title!;
                              solutionController.text = task.solution!;
                              return Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width / 2 - 80,
                                      child: TextField(
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          label: Text('Задание'),
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: titleController,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 2 - 80,
                                      child: TextField(
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          label: Text('Ответ'),
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: solutionController,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          task.title = titleController.text;
                                          task.solution = solutionController.text;
                                          context.read<EditOlympicsBloc>().add(UpdateTaskEvent(state.olympicsPath, state.olympics, state.tasks, task, state.results));
                                        },
                                        icon: Icon(Icons.save_as_outlined)
                                    ),
                                    IconButton(
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text('Подтверждение действия'),
                                              content: Container(
                                                height: 220,
                                                width: 340,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                                      child: Text('Вы действительно хотите удалить задание?'),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
                                                      child: Text(task.title!, maxLines: 1, overflow: TextOverflow.ellipsis,),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      height: 0.5,
                                                      color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 56,
                                                      child: TextButton.icon(
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                          context.read<EditOlympicsBloc>().add(DeleteTaskEvent(state.olympicsPath, task, state.tasks, state.olympics, state.results));
                                                        },
                                                        icon: Icon(Icons.delete_outline, color: Colors.redAccent,),
                                                        label: Text('Удалить', style: TextStyle(color: Colors.redAccent),),
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                )
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 0.5,
                                                      color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 56,
                                                      child: TextButton.icon(
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                        },
                                                        icon: Icon(Icons.close_outlined),
                                                        label: Text('Оставить'),
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                                                                )
                                                            )
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                        icon: Icon(Icons.delete_outline)
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 16,),
                      Divider(),
                      SizedBox(height: 16,),
                      Text(
                        'Запрос SQL к базе данных олимпиады',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 90,
                            child: TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                label: Text('Запрос SQL'),
                                border: OutlineInputBorder(),
                              ),
                              controller: queryController,
                            ),
                          ),
                          SizedBox(width: 8,),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 90,
                            child: TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                label: Text('Результат выполнения запроса'),
                                border: OutlineInputBorder(),
                              ),
                              controller: resultController,
                            ),
                          ),
                          TextButton(
                              onPressed: (){
                                context.read<EditOlympicsBloc>().add(ExecuteQueryEvent(state.olympicsPath, state.tasks, state.olympics, queryController.text, state.results));
                              },
                              child: Text(
                                  'Выполнить'
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Visibility(
                        visible: state.results.length != 0,
                          child: Column(
                            children: [
                              Divider(),
                              SizedBox(height: 16,),
                              Container(
                                child: Text(
                                  'Результаты (${state.results.length})',
                                  style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              SizedBox(height: 4,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Table(
                                      defaultColumnWidth: IntrinsicColumnWidth(),
                                      border: TableBorder.all(
                                          color: Colors.black12
                                      ),
                                      children: resultList
                                  ),
                                ),
                              ),
                              SizedBox(height: 16,),
                            ],
                          )
                      ),
                      SizedBox(height: 64,),
                    ],
                  ),
                ),
              )
            );
          }
          else if(state is EditOlympicsLoadingState){
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                title: Text(state.status),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
              title: Text('Олимпиада'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state){
          if(state is EditOlympicsSuccessfulState){
            showStatusSnackbar(context, Colors.green, Icons.check_circle_outline, state.message);
            if(state.needToReturn){
              Navigator.pop(context);
            }
            context.read<HomeOlympicsBloc>().add(GetOlympicsEvent(state.olympicsPath));
          }
          else if(state is EditOlympicsErrorState){
            showStatusSnackbar(context, Colors.red, Icons.error_outline, state.message);
          }
        });
  }
}
