import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';
import 'package:youtube_app/features/home/data/datasources/home_datasources.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_app/features/home/data/dto/video_dto.dart';
import 'package:youtube_app/features/home/domain/entities/video_entity.dart';

class HomeDataSourcesRemoteImp implements HomeDataSources {
  @override
  Future<Either<Failure, List>> getPlayers() async {
    var url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=&type=video&key=AIzaSyDIUpoG88E1MB0u0KhcqV3bf35E8m4E3sk&maxResults=10');

    try {
      final response = await http.get(url);

      final decode = jsonDecode(response.body);

      List listVideos = decode['items'].map((map) {
        return VideoDto.fromJson(map);
      }).toList();
      return Right(listVideos);
    } on HttpException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getSuggestions(String query) async {
    var url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&key=AIzaSyDIUpoG88E1MB0u0KhcqV3bf35E8m4E3sk&maxResults=10');

    try {
      var response = await http.get(url);

      final decode = jsonDecode(response.body);
      inspect(decode);

      List listVideos = decode['items'].map((map) {
        return VideoDto.fromJson(map);
      }).toList();

      return Right(listVideos);
    } on HttpException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }
}
