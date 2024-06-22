// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/feauters/main_screen.dart';
import 'package:maine_app/services/auth_service.dart';
import 'package:maine_app/services/sync_service/sync_service.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});

  final SyncService syncService = GetIt.I.get<SyncService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEA434),
          title: const Center( child: Text(
            'Авторизуйтесь',
            style: TextStyle(
              fontFamily: 'Kinoble',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFFFF9648)),
                    );
                  },
                );

                final user = await AuthService().signInWithGoogle(syncService);

                
                Navigator.of(context).pop();

                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                }
              },
              child: const Text(
                'Google Sign-In',
                style: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
