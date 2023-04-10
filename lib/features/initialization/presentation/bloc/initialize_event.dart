import 'package:flutter/material.dart';

abstract class InitializeEvent {}

class InitializeNavigate implements InitializeEvent {
  BuildContext context;
  String routeName;

  InitializeNavigate(this.context, this.routeName);
}
