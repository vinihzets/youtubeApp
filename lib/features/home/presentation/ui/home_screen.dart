import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_app/core/architeture/bloc_builder.dart';
import 'package:youtube_app/core/architeture/bloc_state.dart';
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
              inspect(video);
              return ListView(
                children: video.map((e) {
                  final controller = YoutubePlayerController(
                    initialVideoId: e.videoId,
                  );
                  return YoutubePlayerBuilder(
                    builder: (BuildContext context, _) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            controller.load(e.videoId);

                            // controller.toggleFullScreenMode();
                            await controller.play();
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 12.0),
                          child: Column(
                            children: [
                              Text(e.title),
                              Image.network(e.imageHigh)
                            ],
                          ),
                        ),
                      );
                    },
                    player: YoutubePlayer(controller: controller),
                  );
                }).toList(),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
