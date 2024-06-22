import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/theme_parameters.dart';
import 'package:maine_app/domain/user_theme.dart';

class ChangeColor extends StatefulWidget {
  const ChangeColor({
    required this.parameterName,
    required this.themeParameters,
    required this.startColor,
    required this.onColorSelected,
    super.key
  });

  final String parameterName;
  final ThemeParameters themeParameters;
  final Color startColor;
  final ValueChanged<(ThemeParameters, String)> onColorSelected;

  @override
  ChangeColorState createState() => ChangeColorState();
}

class ChangeColorState extends State<ChangeColor> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.startColor;
  }

  void _showColorPicker(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите цвет'),
          backgroundColor: theme.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
            side: BorderSide(color: theme.borderColor, width: 2.0),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  currentColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Готово'),
              onPressed: () {
                widget.onColorSelected((widget.themeParameters, currentColor.value.toString()));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final UserTheme theme = GetIt.I.get<UserTheme>();
    return GestureDetector(
      onTap: () => _showColorPicker(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.parameterName == 'Цвет текста' || widget.parameterName == 'Цвет обводок и границ'
              ? Colors.transparent
              : currentColor,
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
        height: screenSize.height * 0.09,
        width: screenSize.width * 0.91,
        child: Center(
          child: Text(
            widget.parameterName,
            style: TextStyle(
              color: widget.parameterName == 'Цвет текста' || widget.parameterName == 'Цвет обводок и границ'
                  ? currentColor
                  : theme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
