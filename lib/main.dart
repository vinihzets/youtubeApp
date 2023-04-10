import 'package:flutter/material.dart';
import 'package:youtube_app/core/injector/inject.dart';
import 'package:youtube_app/core/utils/consts.dart';
import 'package:youtube_app/features/home/presentation/ui/home_screen.dart';
import 'package:youtube_app/features/initialization/presentation/ui/initialize_screen.dart';

final gConsts = Consts();
void main() {
  Inject.injector();

  runApp(MaterialApp(
    initialRoute: gConsts.initializeScreen,
    routes: {
      gConsts.initializeScreen: (_) => const InitializeScreen(),
      gConsts.homeScreen: (_) => const HomeScreen(),
    },
  ));
}

//  chave api = > AIzaSyDIUpoG88E1MB0u0KhcqV3bf35E8m4E3sk