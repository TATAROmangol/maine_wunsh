// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/theme_parameters.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/thems/widgets/change_color.dart';
import 'package:maine_app/feauters/thems/widgets/change_image.dart';

class ThemsWidgetsView extends StatelessWidget {
  ThemsWidgetsView({super.key});
  
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final Set<(ThemeParameters, String)> selectedColors = {};
  final Repository repository = GetIt.I.get<Repository>();

  void addColor((ThemeParameters, String) info) {
    selectedColors.removeWhere((element) => element.$1 == info.$1);
    selectedColors.add(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center( child: Text('Настройка темы', style: TextStyle(color: theme.textColor))),
        backgroundColor: theme.accentColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ChangeColor(
              parameterName: "Акцент блоков",
              themeParameters: ThemeParameters.blocsColor,
              startColor: theme.blocsColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Акцент блоков управления",
              themeParameters: ThemeParameters.accentColor,
              startColor: theme.accentColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Цвет текста",
              themeParameters: ThemeParameters.textColor,
              startColor: theme.textColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Цвет обводок и границ",
              themeParameters: ThemeParameters.borderColor,
              startColor: theme.borderColor,
              onColorSelected: addColor,
            ),
            ChangeImage(
              parameterName: "Фотография фона",
              onImageSelected: (path) {
                // Assuming you want to store image path in selectedColors as well
                addColor((ThemeParameters.imagePath, path));
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Показать индикатор загрузки
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(color: theme.accentColor),
                        );
                      },
                    );

                    await repository.setTheme();
                    Phoenix.rebirth(context);

                    // Закрыть индикатор загрузки
                    Navigator.of(context).pop();
                  },
                  child: const Text("Стандартная тема"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    // Показать индикатор загрузки
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return  Center(
                          child: CircularProgressIndicator(color: theme.accentColor),
                        );
                      },
                    );

                    await repository.changeTheme(selectedColors.toList());
                    Phoenix.rebirth(context);

                    // Закрыть индикатор загрузки
                    Navigator.of(context).pop();
                  },
                  child: const Text("Применить"),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
