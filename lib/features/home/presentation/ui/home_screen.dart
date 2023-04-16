import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_app/core/architeture/bloc_builder.dart';
import 'package:youtube_app/core/architeture/bloc_state.dart';
import 'package:youtube_app/core/failure/failure.dart';
import 'package:youtube_app/features/home/domain/entities/video_entity.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_event.dart';
import 'package:youtube_app/features/home/presentation/widgets/data_search.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.event.add(HomeEventGetYoutubeVideos(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
            'https://cdn-icons-png.flaticon.com/512/3128/3128307.png'),
        title: const Text(
          'Youtube Player',
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(bloc));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: BlocScreenBuilder(
          stream: bloc.state,
          builder: (state) {
            if (state is BlocStableState) {
              final List video = state.data;

              return _buildData(video);
            } else if (state is BlocLoadingState) {
              return _buildLoading();
            } else if (state is BlocEmptyState) {
              return _buildEmpty();
            } else if (state is BlocErrorState) {
              final errorMessage = state.data;

              return _buildError(errorMessage);
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}

_buildError(Failure errorMessage) {
  return Center(
    child: Container(
      color: Colors.red,
      child: Text(errorMessage.toString()),
    ),
  );
}

_buildEmpty() {
  return const Center(
    child: Text(
      'A lista esta vazia',
      style: TextStyle(fontSize: 20),
    ),
  );
}

_buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

_buildData(List video) {
  return ListView(
    children: video.map((e) {
      final controller = YoutubePlayerController(
        initialVideoId: e.videoId,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
      return YoutubePlayerBuilder(
        builder: (BuildContext context, _) {
          return GestureDetector(
            onTap: () {
              controller.reload();

              controller.load(e.videoId);
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
              // controller.toggleFullScreenMode();
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
              child: Column(
                children: [Text(e.title), Image.network(e.imageHigh)],
              ),
            ),
          );
        },
        player: YoutubePlayer(controller: controller),
      );
    }).toList(),
  );
}
