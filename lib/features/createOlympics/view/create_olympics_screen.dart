import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/home/home_feature.dart';
import 'package:query_quest/repositories/models/Olympics.dart';
import '../../../shared_widgets/show_shack_bar.dart';
import '../../home/olympicsBloc/OlympicsBloc.dart';
import '../create_olympics_feature.dart';

class CreateOlympicsScreen extends StatefulWidget {
  const CreateOlympicsScreen({super.key});

  @override
  State<CreateOlympicsScreen> createState() => _CreateOlympicsScreenState();
}

class _CreateOlympicsScreenState extends State<CreateOlympicsScreen> {
  TextEditingController titleController = TextEditingController(),
   descriptionController = TextEditingController(),
   databaseController = TextEditingController(),
   databaseNameController = TextEditingController(),
   imageController = TextEditingController(),
   startDateController = TextEditingController(),
   startTimeController = TextEditingController(),
   endDateController = TextEditingController(),
   endTimeController = TextEditingController();
  String image = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final olympicsCurrentPath = ModalRoute.of(context)!.settings.arguments as String;

    return BlocConsumer<CreateOlympicsBloc, CreateOlympicsState>(
        builder: (context, state){
          if(state is DefaultCreateOlympicsState || state is SuccessfulOlympicsState){
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text('Создание олимпиады'),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 32,),
                      Visibility(
                        visible: image.isNotEmpty,
                        child: Container(
                          height: 220.0,
                          width: 320.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                        ),
                        replacement: Container(
                          height: 220.0,
                          width: 320.0,
                          child: Icon(
                              Icons.photo_outlined,
                            size: 128,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        width: 520,
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(),
                            labelText: 'Название',
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 520,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.image_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'Изображение (url)',
                          ),
                          onChanged: (value){
                            setState(() {
                              if (isUrl(value)) {
                                image = value;
                              }
                              else{
                                image = "";
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 520,
                        child: TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'Описание',
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 520,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 250,
                                child: TextField(
                                  controller: startDateController,
                                  onTap: (){
                                    final currentDate = DateTime.now();
                                    showDatePicker(
                                        context: context,
                                        locale: Locale('ru'),
                                        initialDate: currentDate,
                                        firstDate: currentDate,
                                        lastDate: DateTime(2036)
                                    ).then((value){
                                      if(value != null){
                                        startDateController.text =
                                        '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
                                      }
                                      else{
                                        startDateController.text =
                                        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.date_range_outlined),
                                    border: OutlineInputBorder(),
                                    labelText: 'Дата начала',
                                  ),
                                )
                            ),
                            Container(
                                width: 250,
                                child: TextField(
                                  controller: startTimeController,
                                  onTap: (){
                                    final time = TimeOfDay.fromDateTime(DateTime.now());
                                    showTimePicker(
                                      context: context,
                                      initialTime: time,
                                    ).then((value){
                                      if(value != null){
                                        startTimeController.text = '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                                      }
                                      else{
                                        startTimeController.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time_outlined),
                                    border: OutlineInputBorder(),
                                    labelText: 'Время начала',
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 520,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 250,
                                child: TextField(
                                  controller: endDateController,
                                  onTap: (){
                                    final currentDate = DateTime.now();
                                    showDatePicker(
                                        context: context,
                                        locale: Locale('ru'),
                                        initialDate: currentDate,
                                        firstDate: currentDate,
                                        lastDate: DateTime(2036)
                                    ).then((value){
                                      if(value != null){
                                        endDateController.text =
                                        '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
                                      }
                                      else{
                                        endDateController.text =
                                        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.date_range_outlined),
                                    border: OutlineInputBorder(),
                                    labelText: 'Дата завершения',
                                  ),
                                )
                            ),
                            Container(
                                width: 250,
                                child: TextField(
                                  controller: endTimeController,
                                  onTap: (){
                                    final time = TimeOfDay.fromDateTime(DateTime.now());
                                    showTimePicker(
                                      context: context,
                                      initialTime: time,
                                    ).then((value){
                                      if(value != null){
                                        endTimeController.text = '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                                      }
                                      else{
                                        endTimeController.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time_outlined),
                                    border: OutlineInputBorder(),
                                    labelText: 'Время завершения',
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 520,
                        child: TextField(
                          controller: databaseNameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(),
                            labelText: 'Имя базы данных',
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: 900,
                        child: TextField(
                          controller: databaseController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 25,
                          decoration: InputDecoration(
                            helperText: 'Не используйте CREATE DATABASE <имя_бд>. Сервер автоматически создаст базу данных на основе имени.',
                            prefixIcon: Icon(Icons.schema_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'Схема базы данных ()',
                          ),
                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        height: 48,
                        width: 280,
                        child: FilledButton.icon(
                            onPressed: (){
                              final olympics = Olympics.empty();
                              olympics.image = image;
                              olympics.startTime = "${startDateController.text}T${startTimeController.text}:00.000Z";
                              olympics.endTime = "${endDateController.text}T${endTimeController.text}:00.000Z";
                              olympics.name = titleController.text;
                              olympics.description = descriptionController.text;
                              olympics.databaseScript = databaseController.text;
                              olympics.databaseName = databaseNameController.text;
                              BlocProvider.of<CreateOlympicsBloc>(context).add(CreateCurrentOlympicsEvent(olympics));
                            },
                            icon: Icon(Icons.add_box_outlined),
                            label: Text('Создать олимпиаду')
                        ),
                      ),
                      SizedBox(height: 128,)
                    ],
                  ),
                ),
              )
            );
          }
          else if(state is LoadingOlympicsState){
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text('Создание олимпиады'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Center(
            child: Text('unknown app state'),
          );
        },
        listener: (context, state){
          if(state is SuccessfulOlympicsState){
            context.read<OlympicsBloc>().add(GetOlympicsEvent(olympicsCurrentPath));
            showStatusSnackbar(context, Colors.green, Icons.check_circle_outline, state.status);
            Navigator.of(context).pop();
          }
          else if(state is ErrorCreateOlympicsState){
            showStatusSnackbar(context, Colors.red, Icons.error_outline, state.status);
          }
        });
  }

  bool isUrl(String text) {
    final regex = RegExp(
      r'^(http:\/\/|https:\/\/|www\.|ftp:\/\/)?[a-zA-Z0-9]+(\.[a-zA-Z]{2,})+(\/\S*)?(.jpg|.jpeg)$',
    );
    return regex.hasMatch(text);
  }
}
