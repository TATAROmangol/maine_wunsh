// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/feauters/main_screen.dart';
import 'package:maine_app/services/sync_service/sync_service.dart';

class SyncView extends StatefulWidget {
   SyncView({super.key});

  final SyncService syncService = GetIt.I.get<SyncService>();

  @override
  SyncViewState createState() => SyncViewState();
}

class SyncViewState extends State<SyncView> {
  @override
  void initState() {
    super.initState();
    _checkConnectivityAndSync();
  }

  Future<void> _checkConnectivityAndSync() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    await widget.syncService.updateDataBetweenFirebaseAndRealm();
  }
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const MainScreen()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEA434),
        title: const Text('Syncing Data'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
