import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/createOlympics/bloc/create_olympics_state.dart';
import 'package:query_quest/features/home/home_feature.dart';
import '../../../shared_widgets/show_shack_bar.dart';
import '../edit_olympics_feature.dart';

import '../../../repositories/models/Olympics.dart';

class EditOlympicsScreen extends StatefulWidget {
  const EditOlympicsScreen({super.key});

  @override
  State<EditOlympicsScreen> createState() => _EditOlympicsScreenState();
}

class _EditOlympicsScreenState extends State<EditOlympicsScreen> {

  TextEditingController newTitleController = TextEditingController();
  TextEditingController newSolutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditOlympicsBloc, EditOlympicsState>(
        builder: (context, state){
          if(state is EditOlympicsDefaultState){
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                title: Text(state.olympics.name!),
                actions: [
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
                                      context.read<EditOlympicsBloc>().add(DeleteOlympicsEvent(state.olympics, state.olympicsPath));
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
                          'Задания',
                          style: TextStyle(
                            fontSize: 48,
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                controller: newTitleController,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 80,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                controller: newSolutionController,
                              ),
                            ),
                            IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.add)
                            ),
                            SizedBox(width: 40,)
                          ],
                        ),
                      ),
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
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: titleController,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 2 - 80,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: solutionController,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: (){

                                        },
                                        icon: Icon(Icons.save_as_outlined)
                                    ),
                                    IconButton(
                                        onPressed: (){

                                        },
                                        icon: Icon(Icons.delete_outline)
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      )
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
            Navigator.pop(context);
            context.read<OlympicsBloc>().add(GetOlympicsEvent(state.olympicsPath));
          }
          else if(state is EditOlympicsErrorState){
            showStatusSnackbar(context, Colors.red, Icons.error_outline, state.message);
          }
        });
  }
}
