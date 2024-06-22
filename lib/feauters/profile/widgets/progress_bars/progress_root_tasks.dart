import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/steps.dart';
import 'package:maine_app/domain/user_theme.dart';

class ProgressRootTaskWidget extends StatelessWidget {
  ProgressRootTaskWidget({super.key});

  final Repository repository = GetIt.I.get<Repository>();
  final UserTheme theme = GetIt.I.get<UserTheme>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<(int, int)>(
      future: repository.getProgressTasks(Steps.rootTask),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: theme.blocsColor,
            ),
            height: screenSize.height * 0.12,
            width: screenSize.width * 0.90,
            margin: EdgeInsets.only(
              bottom: screenSize.height * 0.018,
              left: screenSize.width * 0.05,
              right: screenSize.width * 0.05,
            ),
            child: Row(
              children: [
                const Spacer(),
                const Text("Достигнуто мечт: "),
                const Spacer(),
                Text('${tasks.$2}/${tasks.$1}'),
                const Spacer(),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
