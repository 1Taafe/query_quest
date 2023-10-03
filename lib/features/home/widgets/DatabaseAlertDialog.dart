import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_feature.dart';
import '../../../../repositories/models/Database.dart';
import '../../../../repositories/models/User.dart';

class DatabaseAlertDialog extends StatefulWidget {
  final String database;
  final User user;
  const DatabaseAlertDialog(this.database, this.user);

  @override
  State<DatabaseAlertDialog> createState() => _DatabaseAlertDialogState();
}

class _DatabaseAlertDialogState extends State<DatabaseAlertDialog> {

  String? _selectedDatabase;

  @override
  void initState(){
    super.initState();
    setState(() {
      _selectedDatabase = widget.database;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выбор СУБД'),
      content: Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            RadioListTile<String>(
              value: Database.Postgresql,
              groupValue: _selectedDatabase,
              onChanged: (String? value) {
                setState(() {
                  _selectedDatabase = value;
                });
              },
              title: Text(Database.Postgresql),
              subtitle: const Text('По умолчанию'),
            ),
            RadioListTile<String>(
              value: Database.Oracle,
              groupValue: _selectedDatabase,
              onChanged: null,
              title: Text(Database.Oracle),
              //subtitle: const Text(''),
            ),
            RadioListTile<String>(
              value: Database.SqlServer,
              groupValue: _selectedDatabase,
              onChanged: null,
              title: Text(Database.SqlServer),
              //subtitle: const Text(''),
            ),
            RadioListTile<String>(
              value: Database.MySql,
              groupValue: _selectedDatabase,
              onChanged: null,
              title: Text(Database.MySql),
              //subtitle: const Text(''),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: (){
            //context.read<HomeBloc>().add(SetDatabaseEvent(_selectedDatabase!, widget.user));
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
