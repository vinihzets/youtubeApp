import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_app/core/architeture/bloc_builder.dart';
import 'package:youtube_app/core/architeture/bloc_state.dart';
import 'package:youtube_app/features/home/data/dto/video_dto.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_event.dart';
import 'package:youtube_app/features/home/presentation/ui/video_details_screen.dart';

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
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.event.add(HomeEventGetSuggestions(context, query));
    return BlocScreenBuilder(
      stream: bloc.stateSearch,
      builder: (state) {
        if (state is BlocStableState) {
          final List searchs = state.data;
          return ListView.builder(
            itemCount: searchs.length,
            itemBuilder: (context, index) {
              final search = searchs[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoDetailsScreen(video: search)));
                },
                leading: const Icon(Icons.arrow_forward),
                title: Text(search.title),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
