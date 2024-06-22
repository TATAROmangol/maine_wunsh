import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/services/auth_service.dart';
import 'package:maine_app/services/sync_service/sync_service.dart';

class LogOutWidget extends StatelessWidget {
  LogOutWidget({super.key});

  final SyncService syncService = GetIt.I.get<SyncService>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final UserTheme theme = GetIt.I.get<UserTheme>();
    return Container(
      height: screenSize.height * 0.05,
      width: screenSize.width * 0.54,
      margin: EdgeInsets.only(
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
      ),
      child: ElevatedButton(
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

          await AuthService().logOut(context, syncService);

          // Закрыть индикатор загрузки
          Navigator.of(context).pop();
        },
        child: const Text("Сменить аккаунт"),
      ),
    );
  }
}
