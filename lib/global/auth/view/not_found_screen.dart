import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 160,
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Вы попали на эту страницу поскольку запрашиваемая страница недоступна из-за отсутствия необходимых данных.'
                    ),
                    Text(
                        'Не расстраивайтесь и попробуйте снова.'
                    ),
                    Text(
                        ':)'
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
