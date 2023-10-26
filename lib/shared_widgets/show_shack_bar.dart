import 'package:flutter/material.dart';

void showStatusSnackbar(BuildContext context, Color background, IconData icon, String text, [Color foreground = Colors.white]){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: background,
      content: Row(
        children: [
          Icon(
            icon,
            color: foreground,
            size: 24,
          ),
          SizedBox(width: 16,),
          Text(
              text,
              style: TextStyle(
                  fontSize: 18
              )
          ),
        ],
      )
  ));
}