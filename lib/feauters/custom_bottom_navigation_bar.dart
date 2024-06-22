import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int, TasksTreesBloc) onInit;
  final Function(int, TasksTreesBloc) onReload;
  final UserTheme theme = GetIt.I.get<UserTheme>();

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onInit,
    required this.onReload,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reloadBloc = BlocProvider.of<TasksTreesBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
    return ClipPath(
      clipper: BottomAppBarClipper(),
      child: Container(
        height: screenSize.height * 0.075,
        color: theme.accentColor,
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Spacer(),
              TextButton(
                child: Image.asset(
                    width: screenSize.height * 0.035,
                    height: screenSize.height * 0.035,
                    'assets/icons/profile.png'),
                onPressed: () => onReload(0, reloadBloc),
              ),
              Spacer(),
              TextButton(
                child: Image.asset(
                    width: screenSize.height * 0.035,
                    height: screenSize.height * 0.035,
                    'assets/icons/theme_settings.png'),
                onPressed: () => onReload(1, reloadBloc),
              ),
              Spacer(),
              Image.asset(
                  height: screenSize.height * 0.055, 'assets/icons/logo.png'),
              Spacer(),
              TextButton(
                child: Image.asset(
                    width: screenSize.height * 0.035,
                    height: screenSize.height * 0.035,
                    'assets/icons/complete.png'),
                onPressed: () => onInit(2, reloadBloc),
              ),
              Spacer(),
              TextButton(
                
                child: Image.asset(
                    width: screenSize.height * 0.035,
                    height: screenSize.height * 0.035,
                    'assets/icons/tasks.png'),
                onPressed: () => onInit(3, reloadBloc),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 20.0;
    final Path path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
