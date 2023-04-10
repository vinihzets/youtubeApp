import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_app/features/initialization/presentation/bloc/initialize_bloc.dart';
import 'package:youtube_app/features/initialization/presentation/bloc/initialize_event.dart';
import 'package:youtube_app/main.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({super.key});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  late InitializeBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    Future.delayed(const Duration(seconds: 3)).then(
        (_) => bloc.event.add(InitializeNavigate(context, gConsts.homeScreen)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
