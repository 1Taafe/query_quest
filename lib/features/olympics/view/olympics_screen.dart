import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/olympics/olympics_feature.dart';

class OlympicsScreen extends StatefulWidget {
  const OlympicsScreen({super.key});

  @override
  State<OlympicsScreen> createState() => _OlympicsScreenState();
}

class _OlympicsScreenState extends State<OlympicsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OlympicsBloc, OlympicsState>(
      builder: (context, state){
        if(state is OlympicsUnavailableState){
          return UnavailableOlympicsView();
        }
        else if(state is OlympicsAvailableState){
          return AvailableOlympicsView();
        }
        else{
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
              title: Text('Загрузка'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      listener: (context, state){

      },
    );
  }
}
