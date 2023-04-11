import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_app/core/architeture/bloc_builder.dart';
import 'package:youtube_app/core/architeture/bloc_state.dart';
import 'package:youtube_app/features/home/data/dto/video_dto.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_event.dart';

class DataSearch extends SearchDelegate<String> {
  HomeBloc bloc;

  DataSearch(this.bloc);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then(
      (_) => close(context, query),
    );
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.event.add(HomeEventGetSuggestions(context, query));
    return BlocScreenBuilder(
      stream: bloc.stateSearch,
      builder: (state) {
        if (state is BlocStableState) {
          final List searchs = state.data;

          return ListView(
            children: searchs
                .map((e) => ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title: Text(e.title),
                    ))
                .toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
