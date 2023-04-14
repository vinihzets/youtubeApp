import 'package:flutter/material.dart';

abstract class HomeEvent {}

class HomeEventGetSuggestions implements HomeEvent {
  BuildContext context;
  String query;

  HomeEventGetSuggestions(this.context, this.query);
}

class HomeEventGetYoutubeVideos implements HomeEvent {
  BuildContext context;

  HomeEventGetYoutubeVideos(this.context);
}
