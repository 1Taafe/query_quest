import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../edit_olympics_feature.dart';

import '../../../repositories/models/Olympics.dart';

class EditOlympicsScreen extends StatefulWidget {
  const EditOlympicsScreen({super.key});

  @override
  State<EditOlympicsScreen> createState() => _EditOlympicsScreenState();
}

class _EditOlympicsScreenState extends State<EditOlympicsScreen> {

  @override
  Widget build(BuildContext context) {

    final olympics = ModalRoute.of(context)!.settings.arguments as Olympics;

    return BlocConsumer<EditOlympicsBloc, EditOlympicsState>(
        builder: (context, state){
          if(state is EditOlympicsDefaultState){
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                title: Text(olympics.name!),
                actions: [
                  ElevatedButton.icon(
                    onPressed: (){
                      //show alertdialog
                    },
                    icon: Icon(Icons.delete_outline),
                    label: Text('Удалить'),
                  ),
                  SizedBox(width: 16,)
                ],
              ),
            );
          }
          return Center(
            child: Text('something wrong happend :('),
          );
        },
        listener: (context, state){

        });
  }
}
