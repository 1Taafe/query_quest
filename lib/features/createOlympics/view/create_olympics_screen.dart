import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_olympics_feature.dart';

class CreateOlympicsScreen extends StatefulWidget {
  const CreateOlympicsScreen({super.key});

  @override
  State<CreateOlympicsScreen> createState() => _CreateOlympicsScreenState();
}

class _CreateOlympicsScreenState extends State<CreateOlympicsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOlympicsBloc, CreateOlympicsState>(
        builder: (context, state){
          if(state is DefaultCreateOlympicsState){
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text('Создание олимпиады'),
              ),
              body: Text(' state'),
            );
          }
          return Center(
            child: Text('unknown app state'),
          );
        },
        listener: (context, state){

        });
  }
}
