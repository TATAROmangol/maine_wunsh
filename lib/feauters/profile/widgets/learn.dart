import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';

class TutorialButton extends StatelessWidget {
  const TutorialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => TutorialDialog(),
        );
      },
      child: const Text("Обучение"),
    );
  }
}

class TutorialDialog extends StatelessWidget {
  TutorialDialog({super.key});
  final List<String> images = [
    "assets/learn/Group_1.jpg",
    "assets/learn/Group_2.jpg",
    "assets/learn/Group_3.jpg",
    "assets/learn/Group_4.jpg",
    "assets/learn/Group_5.jpg",
    "assets/learn/Group_6.jpg",
    "assets/learn/Group_7.jpg",
    "assets/learn/Group_10.jpg",
    "assets/learn/Group_11.jpg",
    "assets/learn/Group_13.jpg",
    "assets/learn/Group_14.jpg",
    "assets/learn/Group_15.jpg",
    "assets/learn/Group_17.jpg",
    "assets/learn/Group_18.jpg",
    "assets/learn/Group_19.jpg",
    "assets/learn/Group_20.jpg",
    "assets/learn/Group_21.jpg",
    "assets/learn/Group_22.jpg",
    "assets/learn/Group_23.jpg",
    "assets/learn/Group_24.jpg",
    "assets/learn/Group_26.jpg",
    "assets/learn/Group_27.jpg",
    "assets/learn/Group_28.jpg",
    "assets/learn/Group_29.jpg",
    "assets/learn/Group_30.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    return Dialog(
      backgroundColor: theme.accentColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  color: theme.accentColor,
                  child: Image.asset(images[index], fit: BoxFit.fill),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Закрыть"),
          ),
        ],
      ),
    );
  }
}
