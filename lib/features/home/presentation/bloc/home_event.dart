import 'package:flutter/material.dart';

abstract class HomeEvent {}

class HomeEventGetSuggestions implements HomeEvent {
  BuildContext context;
  String query;

  HomeEventGetSuggestions(this.context, this.query);
}
